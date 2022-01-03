using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doan.Models;
using PagedList;
using PagedList.Mvc;

namespace doan.Controllers
{
    public class BlogController : Controller
    {
        // GET: Blog
        public ActionResult Blogs(int? page)
        {
            int pageSize = 2;
            int pageNum = (page ?? 1);
            var blg = new Common();
            var blgs = blg.listPage(20);
            return View(blgs.ToPagedList(pageNum, pageSize));
        }

        public ActionResult BlogsContent(String MaBV)
        {
            ShopOnline db = new ShopOnline();
            BaiViet blg = db.BaiViets.Where(s => s.maBV == MaBV).First<BaiViet>();
            ViewData["Xembai"] = blg;
            return View();
        }
    }
}