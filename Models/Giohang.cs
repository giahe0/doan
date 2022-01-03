using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using doan.Models;

namespace doan.Models
{
    public class Giohang
    {
        ShopOnline db = new ShopOnline();
        public string Masanpham{ get; set; }
        public string tensanpham { get; set; }
        public DateTime NgayGiao { get; set; }
        public string hinhsanpham { get; set; }
        public decimal dongia { get; set; }
        public int SOLUONG { get; set; }
        public decimal Thanhtien { get { return dongia* SOLUONG; } }
        public DateTime NgayDat { get; set; }
        
        public Giohang()
        {
            this.NgayDat = DateTime.Now;
            this.NgayGiao = DateTime.Now.AddDays(2);
        }
        
        public Giohang(string Masp,int sl)
        {
            this.Masanpham = Masp;
            SanPham sp = db.SanPhams.Single(n => n.maSP == Masp);
            this.tensanpham = sp.tenSP;
            this.hinhsanpham = sp.hinhDD;
            this.dongia = sp.giaBan.Value;
            this.SOLUONG = sl;
            this.SOLUONG = 1;
        }
        public Giohang(string Masp)
        {
            Masanpham = Masp;
            SanPham spham = db.SanPhams.Single(s => s.maSP.Equals(Masp));
            tensanpham = spham.tenSP;
            hinhsanpham = spham.hinhDD;
            dongia = spham.giaBan.Value;
            SOLUONG = 1;
        }
    }
}
