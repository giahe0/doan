using doan.App_Start;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Optimization;
using doan.Models;

namespace doan
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            //----Register your bundle here
            BundleCollection bundles = BundleTable.Bundles;
            BundleConfig.RegisterBundle(bundles);
        }
        protected void Session_Star(Object sender, EventArgs e)
        {
            Session["TTdangnhap"] = null;
        }
    }
}
