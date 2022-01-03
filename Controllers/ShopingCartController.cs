using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using doan.Models;
using System.Data.Entity;


namespace doan.Controllers
{
    public class ShopingCartController : Controller
    {
        ShopOnline db = new ShopOnline();

        public List<Giohang> layGiohang()
        {
            //-----lấy giỏ hàng từ session ra
            List<Giohang> list = Session["Giohang"] as List<Giohang>;
            if (list == null)
            {
                list = new List<Giohang>();
                Session["Giohang"] = list;
            }
            return list;
        }

        public ActionResult ThemGiohang(string Masp,string strURL)
        {
            SanPham sp = db.SanPhams.SingleOrDefault(s => s.maSP.Equals(Masp));
            if(sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            List<Giohang> list = layGiohang();
            Giohang spham = list.Find(s => s.Masanpham.Equals(Masp));
            if(spham != null)
            {
                spham.SOLUONG++;
                return Redirect(strURL);
            }
            Giohang itemGH = new Giohang(Masp);
            list.Add(itemGH);
            return Redirect(strURL);
        }

        private int TongSoLuong()
        {
            int tongsoluong = 0;
            List<Giohang> list = Session["Giohang"] as List<Giohang>;
            if(list != null)
            {
                tongsoluong = list.Sum(n => n.SOLUONG);
            }
            return tongsoluong;
        }
        private decimal TongTien()
        {
            decimal tongtien = 0;
            List<Giohang> list = Session["Giohang"] as List<Giohang>;
            if(list != null)
            {
                tongtien = list.Sum(n => n.Thanhtien);
            }
            return tongtien;
        }

        public ActionResult Giohang()
        {
            List<Giohang> list = layGiohang();
            if(list.Count == 0)
            {
                return View("ThongBao");
            }
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(list);

        }
        public ActionResult ThongBao()
        {
            return View();
        }
        public ActionResult GiohangPartial()
        {
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return PartialView();
        }

        public ActionResult XoaGiohang(string MASP)
        {
            List<Giohang> list = layGiohang();
            Giohang spham = list.SingleOrDefault(s => s.Masanpham.Equals(MASP));
            if(spham != null)
            {
                list.RemoveAll(n => n.Masanpham.Equals(MASP));
                return RedirectToAction("Giohang","ShopingCart");
            }    
            if(list.Count == 0)
            {
                return View("ThongBao");
            }
            return RedirectToAction("Giohang", "ShopingCart");
        }
        public ActionResult CapnhatGH(string MASP,FormCollection f)
        {
            List<Giohang> list = layGiohang();
            Giohang sp = list.SingleOrDefault(s => s.Masanpham.Equals(MASP));
            if(sp != null)
            {
                sp.SOLUONG = int.Parse(f["SOLUONG"].ToString());
            }
            return RedirectToAction("Giohang");
        }

        [HttpGet]
        public ActionResult DatHang()
        {
            if(Session["TTdangnhap"] ==null || Session["TTdangnhap"].ToString() =="")
            {
                return RedirectToAction("Login", "User");
            }    
            KhachHang x = new KhachHang();
            List<Giohang> list = Session["Giohang"] as List<Giohang>;
            ViewData["DatHang"] = list;
            ViewBag.Tongsoluong = TongSoLuong();
            ViewBag.Tongtien = TongTien();
            return View(x);
        }
        [HttpPost]
        public ActionResult SaveToDataBase(KhachHang x)
        {
            using(var context = new ShopOnline())
            {
                using(DbContextTransaction trans = context.Database.BeginTransaction())
                {
                    try
                    {
                        //----Update customer info to KH obj you have creat....
                        x.maKH = x.soDT;
                        //----Add customer info to Data model----
                        context.Set<KhachHang>().Add(x);
                        //--------Save to database-----[Table KH]-----
                        context.SaveChanges();
                        //--------New an Order obj and add to DonHang-------[Table DH]----
                        DonHang d = new DonHang();
                        d.soDH = string.Format("{0:yyMMddhhmm}", DateTime.Now);
                        d.maKH = x.maKH;
                        d.ngayDat = DateTime.Now;d.ngayGH = DateTime.Now.AddDays(5);
                        d.taiKhoan = "admin";d.diaChiGH = x.diaChi;
                        //-------Add order inggo to data model--------
                        context.DonHangs.Add(d);
                        //--------Save to database--------[Table DH]-------
                        context.SaveChanges();
                        //---------Get list of items from Giohang--[Table CtDonhang]----
                        List<Giohang> list = layGiohang();
                        //------Update order info to DonHang obj---------
                        foreach (var i in list)
                        {
                            CtDonHang ctdh = new CtDonHang();
                            ctdh.maSP = i.Masanpham;
                            ctdh.soDH = String.Format("{0:yyMMddhhmm}", DateTime.Now);
                            ctdh.soLuong = i.SOLUONG;
                            ctdh.giaBan = (long)(i.dongia);
                            context.CtDonHangs.Add(ctdh);
                        }
                        //------Save to database----------[Table Ctdonhang]
                        context.SaveChanges();
                        trans.Commit();
                        Session["Giohang"] = null;
                        return RedirectToAction("TBthanhcong", "ShopingCart");
                    }catch
                    {
                        trans.Rollback();
                    }
                }    
            }    
            return RedirectToAction("DatHang", "ShopingCart");
        }

        public ActionResult TBthanhcong()
        {
            return View();
        }
    }
}