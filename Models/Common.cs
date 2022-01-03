using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using PagedList;
using PagedList.Mvc;

namespace doan.Models
{
    
    public class Common
    {
        /// <summary>
        /// Hàng lấy danh sách 
        /// </summary>
        public static List<SanPham> getProducts()
        {
            List<SanPham> l = new List<SanPham>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("ShopOnline");
            //---Lấy dữ liệu
            l = cn.Set<SanPham>().ToList<SanPham>();
            return l;
        }

        public static List<SanPham> getProductByLoaiSP(int maLoai)
        {
            List<SanPham> ml = new List<SanPham>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("ShopOnline");
            //---Lấy dữ liệu
            ml = cn.Set<SanPham>().Where(x => x.maLoai == maLoai).ToList<SanPham>();
            return ml;
        }
        /// <summary>
        /// Hàng lấy danh sách các chủng loại hàng hoá 
        /// </summary>
        /// 
        public static List<LoaiSP> getCategories()
        {
            List<LoaiSP> loai = new List<LoaiSP>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("ShopOnline");
                //---Lấy dữ liệu
                loai =  cn.Set<LoaiSP>().Where(s => s.maLoai > 27 && s.maLoai < 31).ToList<LoaiSP>();
            return loai;
        }
        public static List<LoaiSP> getCateMouse()
        {
            List<LoaiSP> l = new List<LoaiSP>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext c = new DbContext("ShopOnline");
                //---Lấy dữ liệu
                l =  c.Set<LoaiSP>().Where(s => s.maLoai > 30).ToList<LoaiSP>();
            return l;
        }

        public static List<SanPham> getMS()
        {
            List<SanPham> ms = new List<SanPham>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("ShopOnline");
            //---Lấy dữ liệu
            ms = cn.Set<SanPham>().Where(i => i.maLoai > 9 && i.maLoai < 16).ToList<SanPham>();
            return ms;
        }
        public static List<BaiViet> GetBlog()
        {
            List<BaiViet> blg = new List<BaiViet>();
            ShopOnline db = new ShopOnline();
            blg = db.BaiViets.OrderByDescending(s => s.ngayDang).ToList<BaiViet>();
            return blg;
        }

        public List<BaiViet> listPage(int count)
        {
            List<BaiViet> lists = new List<BaiViet>();
            DbContext db = new DbContext("ShopOnline");
            lists = db.Set<BaiViet>().OrderByDescending(o => o.ngayDang).Take(count).ToList<BaiViet>();
            return lists;
        }
        public List<SanPham> listAllPaging(int count,int maLoai)
        {
            List<SanPham> list = new List<SanPham>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext db = new DbContext("ShopOnline");
            //---Lấy dữ liệu
            list = db.Set<SanPham>().OrderByDescending(x=>x.maSP).Where(s=>s.maLoai == maLoai).Take(count).ToList<SanPham>();
            return list;
        }
        public static SanPham getProductById(string maSP)
        {
            DbContext cn = new DbContext("ShopOnline");
            return cn.Set<SanPham>().Find(maSP);
        }
    }
}