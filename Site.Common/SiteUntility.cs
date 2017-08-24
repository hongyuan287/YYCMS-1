using System;
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

        public static string GetDomainCateUrl(string cateId)
        {
            if (string.IsNullOrEmpty(cateId))
            {
                return "/";
            }
            return string.Format("http://{0}/list/{1}.html", ConfigurationManager.AppSettings["SiteDomain"], cateId);
        }

        public static string GetRelationDetailUrl(string c_gid)
        {
            return string.Format("/detail/{0}.html", c_gid);
        }

        public static string GetDomainDetailUrl(string cateId, string c_gid)
        {
            return string.Format("http://{0}/detail/{1}.html", ConfigurationManager.AppSettings["SiteDomain"], c_gid);
        }


    }
}