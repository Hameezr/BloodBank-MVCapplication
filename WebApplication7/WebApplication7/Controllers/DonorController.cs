using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using db_connectivity.Models;

namespace WebApplication7.Controllers
{
    public class DonorController : Controller
    {
        int result;
        // GET: Donor
        public ActionResult Index()
        {

            if (Session["doncnic"] != null)
            {

                return View("Index", TempData["doninfo"]);
            }
            else
                return RedirectToAction("Index", "Home");
           
        }
        public ActionResult DonLogout()
        {
            
           
            Session.Remove("doncnic");
            Session.Abandon();
            
            return RedirectToAction("Index", "Home");
        }

        public ActionResult authenticateDonLogin(String cnic, String password)
        {
            result = CRUD.Login(cnic, password);
            if (result == -1)
            {
                String data = "Something went wrong while connecting with the database.";
                ViewBag.dataval = data;
                return View("~/Views/Home/Index.cshtml", (object)data);
            }

            else if (result == 1)
            {
                String data = "User is Banned";
                ViewBag.dataval = data;
                return View("~/Views/Home/Index.cshtml", (object)data);
            }
            else if (result == 3 || result == 5)
            {
                String data = "Incorrect Credentials";
                ViewBag.dataval = data;
                return View("~/Views/Home/Index.cshtml",(object)data);
            }
            else if (result == 4)
            {
                String data = "Too much wrong Attempts.User banned for 2 Minutes";
                ViewBag.dataval = data;
                return View("~/Views/Home/Index.cshtml", (object)data);
            }
            else
            {
                Session["doncnic"] = cnic;
                List<String> logininfo = CRUD.GetDonInfo(cnic);
                ViewBag.info = logininfo;
                TempData["doninfo"] = logininfo;
                return RedirectToAction("Index","Donor");
            }

        }


    }
}