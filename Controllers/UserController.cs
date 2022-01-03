using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doan.Models;

namespace doan.Controllers
{
    
    
    public class UserController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        // GET: Register-------------------------------------------

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(TaiKhoan tk)
        {
            ShopOnline dk = new ShopOnline();
            if (ModelState.IsValid)
            {
                var checkEmail = dk.TaiKhoans.FirstOrDefault(s => s.email == tk.email);
                var checkTK = dk.TaiKhoans.FirstOrDefault(f => f.taiKhoan1 == tk.taiKhoan1);
                if (checkEmail != null )
                {
                    ViewBag.Error = "Email đã tồn tại";
                    return View();
                }
                else if(checkTK != null)
                {
                    ViewBag.Error = "Tài khoản đã tồn tại";
                    return View();
                }    
                else                 
                {
                    tk.matKhau = Security.encrytSHA256(tk.matKhau);
                    dk.Configuration.ValidateOnSaveEnabled = false;
                    dk.TaiKhoans.Add(tk);
                    dk.SaveChanges();
                    return RedirectToAction("Login", "User");
                }  
            }
            return View();
        }

        //----Get: Login-----------------------------------------------
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
         public ActionResult Login(string acc, string pass)
        {
            string mk = Security.encrytSHA256(pass);
            if (String.IsNullOrEmpty(acc))
            {
                ViewData["loi"] = "Tài khoản không được để trống";
            }
            else if (String.IsNullOrEmpty(pass))
            {
                ViewData["loi2"] = "Mật khẩu không được để trống";
            }
            else
            {
                //---Đọc thông tin tài khoản từ Database
                TaiKhoan ttdn2 = new ShopOnline().TaiKhoans.SingleOrDefault(n => n.taiKhoan1 == acc && n.matKhau.Equals(mk));
                if(ttdn2 != null)
                {
                    Session["TTdangnhap"] = ttdn2;
                    Session["TenDangNhap"] = acc;
                    return RedirectToAction("Index", "Home");
                }    
                else { ViewBag.Thongbao = "Tên đăng nhập hoặc mật khẩu không đúng"; } 
            }
            return View();
        }

        public ActionResult LogOut()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Index","Home");
        }
    }
}