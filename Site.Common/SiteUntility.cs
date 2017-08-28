﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Site.Common;
using System.Configuration;

namespace Site.Common
{
    /// <summary>
    /// CMS后台工具类
    /// </summary>
    public class SiteUntility
    {
        public static string GetRelationCateUrl(string cateId)
        {
            if (string.IsNullOrEmpty(cateId.Trim(' ')))
            {
                return "/";
            }
            return string.Format("/list/{0}.html", cateId);
        }

        private static string GetRelationCatePageUrl(string cateId, int pageIndex)
        {
            if (string.IsNullOrEmpty(cateId.Trim(' ')))
            {
                return "/";
            }
            return string.Format("/list/{0}_{1}.html", cateId, pageIndex);
        }

        public static string GetDomainCateUrl(string cateId)
        {
            if (string.IsNullOrEmpty(cateId))
            {
                return "/";
            }
            return string.Format("http://{0}/list/{1}.html", ConfigurationManager.AppSettings["SiteDomain"], cateId);
        }

        private static string GetDomainCatePageUrl(string cateId, int pageIndex)
        {
            if (string.IsNullOrEmpty(cateId))
            {
                return "/";
            }
            return string.Format("http://{0}/list/{1}_{2}.html", ConfigurationManager.AppSettings["SiteDomain"], cateId, pageIndex);
        }

        public static string GetRelationDetailUrl(string c_gid)
        {
            return string.Format("/detail/{0}.html", c_gid);
        }

        public static string GetDomainDetailUrl(string cateId, string c_gid)
        {
            return string.Format("http://{0}/detail/{1}.html", ConfigurationManager.AppSettings["SiteDomain"], c_gid);
        }


        /// <summary>
        /// 生成分类列表分页Dome
        /// </summary>
        /// <returns></returns>
        public static string CreateListPage(string cateId, int pageSize, int pageIndex, int rowCount)
        {
            /*
             <div class="content_page">
                <a href="#">首页</a>
                <a href="#">上一页</a>
                <a href="#">1</a>
                <a href="#" class="cur">2</a>
                <a href="#">3</a>
                <a href="#">下一页</a>
                <a href="#">尾页</a>
            </div>

            */
            string result = string.Empty;

            string pageHtml = "<div class=\"content_page\">{0}</div>";
            string a_url = string.Empty;
            int totalPage = (int)Math.Ceiling(rowCount * 1.00 / pageSize * 1.00);
            if (totalPage > 1)
            {
                if (pageIndex != 1)
                {
                    a_url += string.Format("<a href=\"{0}\">首页</a>\r\n", GetRelationCateUrl(cateId));
                    a_url += string.Format("<a href=\"{0}\">上一页</a>\r\n", GetRelationCatePageUrl(cateId, pageIndex - 1));
                }

                for (int i = 1; i <= totalPage; i++)
                {
                    a_url += string.Format("<a href=\"{0}\" class=\"{2}\" >{1}</a>\r\n", GetRelationCatePageUrl(cateId, i), i, i == pageIndex ? "cur" : "");
                }

                if (pageIndex != totalPage)
                {
                    a_url += string.Format("<a href=\"{0}\">下一页</a>\r\n", GetRelationCatePageUrl(cateId, pageIndex + 1));
                    a_url += string.Format("<a href=\"{0}\">尾页</a>\r\n", GetRelationCatePageUrl(cateId, totalPage));
                }

                result = string.Format(pageHtml, a_url);
            }

            return result;
        }


    }
}