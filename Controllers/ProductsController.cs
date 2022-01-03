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
    public class ProductsController : Controller
    {
        ShopOnline db = new ShopOnline();

        // GET: Products Asus G
        public ActionResult AsusG(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 1);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        // Get products AcerG
        public ActionResult AcerG(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15,2);
            return View(model.ToPagedList(pageNum,pageSize));
        }

        //  Get products MSIG
        public ActionResult MSIG(int ? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 3);
            return View(model.ToPagedList(pageNum, pageSize));
        }
        
        //  Get products LenovoG
        public ActionResult LenovoG(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 4);
            return View(model.ToPagedList(pageNum, pageSize));

        }

        //  Get products HpG
        public ActionResult HpG(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 5);
            return View(model.ToPagedList(pageNum, pageSize));
        }
        
        //  Get products DellG
        public ActionResult DellG(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 7);
            return View(model.ToPagedList(pageNum, pageSize));
        }  

        //  Get products Gigabyte
        public ActionResult Gigabyte(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 6);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        // GET: Products AsusHT
        public ActionResult AsusHT(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 16);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        // Get products AcerHT
        public ActionResult AcerHT(int? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 17);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        //  Get products MSIHT
        public ActionResult MSIHT(int ? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 18);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        //  Get products LenovoHT
        public ActionResult LenovoHT(int ? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 19);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        //  Get products LgHT
        public ActionResult LgHT(int ? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15, 8);
            return View(model.ToPagedList(pageNum, pageSize));
        }

        //  Get products DellHT
        public ActionResult DellHT(int ? page)
        {
            int pageSize = 8;
            int pageNum = (page ?? 1);
            var dao = new Common();
            var model = dao.listAllPaging(15,20);
            return View(model.ToPagedList(pageNum, pageSize));
        } 
        
        //  Get products chuột Logitech
        public ActionResult cLogi()
        {
            return View();
        }
        
        //  Get products chuột Msi
        public ActionResult cMSi()
        {
            return View();
        }  

        //  Get products chuột Asus
        public ActionResult cAsus()
        {
            return View();
        }

        // GET: Products Office 365
        public ActionResult Office365()
        {
            return View();
        }

        // Get products Office 2021
        public ActionResult Office2021()
        {
            return View();
        }

        //  Get products Windows 10 Home
        public ActionResult W10H()
        {
            return View();
        }

        //  Get products Windows 10 Pro
        public ActionResult W10P()
        {
            return View();
        }

        //  Get products Windows 11 Home
        public ActionResult W11H()
        {
            return View();
        }

        //  Get products Windows 11 Pro
        public ActionResult W11P()
        {
            return View();
        }
    }
}