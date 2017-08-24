using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Site.Service.SiteService.SiteServices;
using Site.Service.SiteService;

namespace Site.Main.Controllers
{
    public class ListController : Controller
    {
        // GET: List
        public ActionResult Index(int cateId)
        {
            int pageSize = 20;
            int pageIndex = 1;



            //查询该分类下所有的文章
            List<Site_Content> list = SiteServiceClass.Site_Content_SelectPageByc_id(cateId, pageIndex, pageSize);


            ViewBag.list = list;
            return View();
        }
    }
}