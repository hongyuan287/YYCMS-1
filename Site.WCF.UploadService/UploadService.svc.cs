﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Xml;
using CustomException;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace UploadService
{
    [ServiceBehavior(Name = "UploadService", Namespace = "http://service.jsonyang.com")]
    public class UploadService : IUploadService
    {
        /// <summary>
        /// 上传图片
        /// </summary>
        /// <param name="imgDatas">二进制数据</param>
        /// <param name="configName">文件保存路径配置名称</param>
        /// <param name="sizeConfig">缩略尺寸设置：尺寸设置 200*120*1 缩略为200*120 使用1号水印图片</param>
        /// <param name="imgExt">扩展名</param>
        /// <returns>原图地址(0)和缩略图地址(1)</returns>
        public List<string> UploadImg(byte[] imgDatas, string configName, List<string> sizeConfig, string imgExt)
        {
            string url = string.Empty;
            List<string> list = GetConfig(configName);
            string guid = Guid.NewGuid().ToString().Substring(0, 16);

            List<string> urlList = SaveImg(imgDatas, guid, imgExt, list[1], list[0], list[2], sizeConfig);


            return urlList;
        }

        #region 1.0 获取配置信息，并创建目录  返回值：【index】0,domain;1,path(物理路径);2,pathFormat - List<string> GetConfig
        /// <summary>
        /// 获取配置信息，并创建目录  返回值：【index】0,domain;1,path(物理路径);2,pathFormat
        /// </summary>
        /// <param name="configName"></param>
        /// <returns></returns>
        private List<string> GetConfig(string configName)
        {
            List<string> list = new List<string>();

            XmlDocument xd = new XmlDocument();
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.IgnoreComments = true;//忽略文档里面的注释
            string path = System.Web.HttpContext.Current.Server.MapPath("~\\Config\\upload.config");
            XmlReader reader = XmlReader.Create(path, settings);
            xd.Load(reader);
            reader.Close();

            XmlNodeList nodeList = xd.DocumentElement.ChildNodes;
            string indexPath = string.Empty;
            XmlNode currentNode = null;
            foreach (XmlNode items in nodeList)
            {
                if (items.Attributes["name"].Value.ToLower() == configName.ToLower())
                {
                    currentNode = items;
                    break;
                }
            }

            if (currentNode == null)
            {
                throw new UploadException("没有找到上传配置节点");
            }

            string _domain = currentNode.SelectNodes("domain")[0].InnerText;
            string _path = currentNode.SelectNodes("path")[0].InnerText;
            string _pathFormat = currentNode.SelectNodes("pathFormat")[0].InnerText;

            _pathFormat = _pathFormat.Replace("yyyy", DateTime.Now.Year.ToString());
            _pathFormat = _pathFormat.Replace("MM", DateTime.Now.Month.ToString().PadLeft(2, '0'));
            _pathFormat = _pathFormat.Replace("dd", DateTime.Now.Day.ToString().PadLeft(2, '0'));

            string fullPath = _path + "\\" + _pathFormat + "\\";

            if (!Directory.Exists(fullPath))
            {
                Directory.CreateDirectory(fullPath);
            }

            list.Add(_domain);
            list.Add(_path);
            list.Add(_pathFormat);

            return list;
        }
        #endregion

        #region 1.1 保存图片 - List<string> SaveImg
        /// <summary>
        /// 保存图片
        /// </summary>
        /// <param name="physicalPath">物理磁盘基地址路径</param>
        /// <param name="domain">域名</param>
        /// <param name="pathFormat">分文件夹格式</param>
        /// <param name="sizeConfig">尺寸设置 200*120*1 缩略为200*120 使用1号水印图片</param>
        /// <param name="fileName">文件名</param>
        /// <param name="imgExt">扩展名</param>
        /// <returns>原图地址(0)和缩略图地址(1)</returns>
        private List<string> SaveImg(byte[] imgDatas, string fileName, string imgExt, string physicalPath, string domain, string pathFormat, List<string> sizeConfig)
        {
            if (imgExt.ToLower() != "jpg" || imgExt.ToLower() != ".jpg")
            {
                imgExt = "jpg";
            }

            try
            {
                List<string> urlList = new List<string>();
                string savePath = physicalPath + pathFormat + "\\" + fileName + (imgExt.Contains(".") ? imgExt : "." + imgExt);


                Stream ms = new MemoryStream(imgDatas);
                Image img = new Bitmap(ms);

                int sourceW = img.Width;
                int sourceH = img.Height;

                string[] sizeArr = null;
                string watermark = string.Empty;
                List<int> realSize = null;
                string zoomImgFullName = physicalPath + pathFormat + "\\" + fileName + "_" + "{0}" + "." + imgExt;
                string dimainImgFullName = domain + pathFormat + "\\" + fileName + "_" + "{0}" + "." + imgExt;
                string physicalFullName = string.Empty;//物理全路径
                string httpFullName = string.Empty;//网络http全路径

                //保存原图
                using (FileStream fs = new FileStream(savePath, FileMode.Create))
                {
                    fs.Write(imgDatas, 0, imgDatas.Length);
                    //添加原图地址
                    urlList.Add((domain + pathFormat + "\\" + fileName + "." + imgExt).Replace("\\", "/"));
                }

                foreach (string item in sizeConfig)
                {
                    //缩略图的物理全路径
                    physicalFullName = string.Format(zoomImgFullName, item).Replace("*", "x");

                    sizeArr = item.Split(new string[] { "*" }, StringSplitOptions.RemoveEmptyEntries);
                    if (sizeArr.Length >= 3)
                    {
                        //获取水印文件编号
                        watermark = sizeArr[2];
                    }
                    //计算缩略尺寸
                    realSize = CalcSize(sourceW, sourceH, Convert.ToInt32(sizeArr[0]), Convert.ToInt32(sizeArr[1]));

                    //如果是gif格式，取第一帧
                    if (img.RawFormat == ImageFormat.Gif)
                    {
                        Guid guids = img.FrameDimensionsList[0];
                        FrameDimension fd = new FrameDimension(guids);
                        img.SelectActiveFrame(fd, 0);
                    }

                    //保存缩略图
                    SaveZoomImg(Convert.ToInt32(sizeArr[0]), Convert.ToInt32(sizeArr[1]), realSize, physicalFullName, img, watermark);

                    httpFullName = string.Format(dimainImgFullName, item).Replace("*", "x").Replace("\\", "/");
                    //添加缩略图地址
                    urlList.Add(httpFullName);
                }
                return urlList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion

        #region 1.2 按照比例缩放尺寸 返回值:[index] 0,W;1,H - List<int> CalcSize
        /// <summary>
        /// 按照比例缩放尺寸 返回值:[index] 0,W;1,H
        /// </summary>
        /// <param name="sourceW">原图尺寸宽</param>
        /// <param name="sourceH">原图尺寸高</param>
        /// <param name="targetW">缩略尺寸宽</param>
        /// <param name="targetH">缩略尺寸高</param>
        private List<int> CalcSize(int sourceW, int sourceH, int targetW, int targetH)
        {
            #region 整图等比缩放 【无效】
            //double ratioW = (double)sourceW / (double)targetW;
            //double ratioH = (double)sourceH / (double)targetH;

            //List<int> realSize = new List<int>();

            //if (ratioW < 1 && ratioH < 1)
            //{
            //    realSize.Add(sourceW);
            //    realSize.Add(sourceH);
            //}
            //else
            //{
            //    if (sourceW >= sourceH)//按照宽的比例来缩放
            //    {
            //        if (ratioW > 1)//系数值有效,以宽缩放
            //        {
            //            targetH = (int)Math.Ceiling((double)sourceH / (double)ratioW);
            //        }
            //        else//以高缩放
            //        {
            //            targetW = (int)Math.Ceiling((double)sourceW / (double)ratioH);

            //        }
            //    }
            //    else//按照高的比例来缩放
            //    {
            //        if (ratioH > 1)//系数值有效,以高缩放
            //        {
            //            targetW = (int)Math.Ceiling((double)sourceW / (double)ratioH);
            //        }
            //        else//以高缩放
            //        {
            //            targetH = (int)Math.Ceiling((double)sourceH / (double)ratioW);
            //        }
            //    }
            //    realSize.Add(targetW);
            //    realSize.Add(targetH);
            //} 
            #endregion


            // 需要生成的缩略图在上述"画布"上的起点位置 
            int X = 0;
            int Y = 0;
            // 根据原始图片及欲生成的缩略图尺寸,计算缩略图的实际尺寸及原始图片需要裁剪后的左边或上面坐标 
            if (targetH * sourceW > targetW * sourceH)
            {
                X = (sourceW - targetW * sourceH / targetH) / 2;
            }
            else
            {
                Y = (sourceH - targetH * sourceW / targetW) / 2;
            }
            //图片经过缩放剪裁后的宽和高
            int W = 0;
            int H = 0;
            W = X > 0 ? sourceW - X * 2 : sourceW;
            H = Y > 0 ? sourceH - Y * 2 : sourceH;


            //返回值:[index] 0,缩略图在画布上的起点位置X; 1,缩略图在画布上的起点位置X; 2,W; 3,H
            List<int> realSize = new List<int>();
            realSize.Add(X);
            realSize.Add(Y);
            realSize.Add(W);
            realSize.Add(H);

            return realSize;

        }
        #endregion

        #region 1.3 保存缩放图 - void SaveZoomImg
        /// <summary>
        /// 保存缩放图
        /// </summary>
        /// <param name="targetW">指定的宽度</param>
        /// <param name="targetH">指定的高度</param>
        /// <param name="targetH">指定的高度</param>
        /// <param name="fullName">物理保存路径</param>
        /// <param name="img">需要缩略的图片</param>
        /// <param name="waterMarkIndex">水印索引号</param>
        private void SaveZoomImg(int targetW, int targetH, List<int> realSize, string fullName, Image img, string waterMarkIndex)
        {
            Bitmap bmp = new Bitmap(targetW, targetH, img.PixelFormat);//最后一个参数： 保持位深度一致
            Graphics g = Graphics.FromImage(bmp);


            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic; //System.Drawing.Drawing2D.InterpolationMode.High;

            g.DrawImage(img, new Rectangle(0, 0, targetW, targetH), new Rectangle(realSize[0], realSize[1], realSize[2], realSize[3]), GraphicsUnit.Pixel);
            g.Save();
            g.Dispose();

            if (!string.IsNullOrEmpty(waterMarkIndex))
            {
                bmp = DrawWaterMark(waterMarkIndex, bmp);
            }

            bmp.Save(fullName, ImageFormat.Jpeg);//一定要标明 保存格式，否则生成的内存大小会很大


            bmp.Dispose();
        }
        #endregion

        #region 1.4 添加水印图片：水印标准 150*20 ，需要添加水印的图片(png格式)，缩略后的尺寸需要 w>=300,h>=40  - DrawWaterMark
        /// <summary>
        /// 添加水印图片：水印标准 150*20 ，需要添加水印的图片(png格式)，缩略后的尺寸需要 w>=300,h>=40
        /// </summary>
        /// <param name="markIndex">水印图片的后缀编号 WaterMark_{1}</param>
        /// <param name="img">缩略后的图片</param>
        private Bitmap DrawWaterMark(string markIndex, Bitmap img)
        {
            if (img.Height >= 40 && img.Width >= 300)
            {
                string waterMarkName = string.Format("WaterMark_{0}.png", markIndex);
                string waterMarkFullName = System.Web.HttpContext.Current.Server.MapPath("~/WaterMark/" + waterMarkName);
                if (!File.Exists(waterMarkFullName))
                {
                    throw new UploadException("没有找到水印图片：" + waterMarkName);
                }


                Bitmap bmp = new Bitmap(waterMarkFullName);
                Graphics g = Graphics.FromImage(img);
                //计算水印起始坐标,偏移 3px
                int sw = img.Width - bmp.Width - 3;//x
                int sh = img.Height - bmp.Height - 3;//y
                g.DrawImage(bmp, new Rectangle(sw, sh, bmp.Width, bmp.Height), 0, 0, bmp.Width, bmp.Height, GraphicsUnit.Pixel);
                g.Save();
                g.Dispose();
                bmp.Dispose();
            }
            return img;
        }
        #endregion

    }
}
