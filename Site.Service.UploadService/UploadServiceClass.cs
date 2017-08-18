using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Site.Service.UploadService.UploadService;
using Site.Common;

namespace Site.Service.UploadService
{
    public class UploadServiceClass
    {
        #region 图片上传

        /// <summary>
        /// 上传图片
        /// </summary>
        /// <param name="imgDatas">二进制数据</param>
        /// <param name="configName">文件保存路径配置名称</param>
        /// <param name="sizeConfig">缩略尺寸设置：尺寸设置 200*120*1 缩略为200*120 使用1号水印图片</param>
        /// <param name="imgExt">扩展名</param>
        /// <returns>原图地址(0)和缩略图地址(1)</returns>
        public static List<string> UploadImg(byte[] imgDatas, string configName, List<string> sizeConfig, string imgExt)
        {
            IUploadService channel = Entity.CreateChannel<IUploadService>(SiteEnum.SiteService.UploadService);
            var result = channel.UploadImg(imgDatas, configName, sizeConfig, imgExt);
            (channel as IDisposable).Dispose();
            return result;
        }

        #endregion
    }
}
