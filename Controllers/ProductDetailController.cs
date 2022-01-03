using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doan.Models;

namespace doan.Controllers
{
    public class ProductDetailController : Controller
    {
        // GET: ProductDetail
        public ActionResult Index(string masp)
        {
            ShopOnline db = new ShopOnline();
            SanPham s = db.SanPhams.Where(x => x.maSP.Equals(masp)).First<SanPham>();
            ViewData["sp"] = s;

            return View();
        }
    }
}