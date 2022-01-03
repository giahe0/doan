using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doan.Models;

namespace doan.Controllers
{
    public class LoginADController : Controller
    {
        [HttpGet]
        // GET: LoginAD
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(string Acc, string Pass)
        {
            string mk = Security.encrytSHA256(Pass);
            //---Đọc thông tin tài khoản từ Database
            if (String.IsNullOrEmpty(Acc))
            {
                ViewData["loi"] = "Tài khoản không được để trống";
            }
            else if (String.IsNullOrEmpty(Pass))
            {
                ViewData["loi2"] = "Mật khẩu không được để trống";
            }
            else
            {
                //---Đọc thông tin tài khoản từ Database
                TaiKhoan ttdn = new ShopOnline().TaiKhoans.SingleOrDefault(n => n.taiKhoan1 == Acc && n.matKhau.Equals(mk));
                if (ttdn != null)
                {
                    Session["TTdangnhap"] = ttdn;
                    Session["TenDangNhap"] = Acc;
                    return RedirectToAction("Index", "Dashboard",new { area = "AdminPage" });
                }
                else { ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng"; }
            }
            return View();
        }
    }
}