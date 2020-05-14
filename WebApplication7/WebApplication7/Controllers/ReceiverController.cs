using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using db_connectivity.Models;
namespace db_connectivity.Controllers
{
    public class ReceiverController : Controller
    {
        int result;
        public ActionResult ReceverView()
        {
            if (Session["cnic"] != null)
            {
               
                return View("ReceverView",TempData["info"]);
            }
            else
                return RedirectToAction("Index", "Home");
        }

        public ActionResult Logout()
        {
            Session["cnic"] = null;
            return RedirectToAction("Index","Home");
        }

        public ActionResult authenticateRecLogin(String cnic, String password)
        {
            result = CRUD.RecLogin(cnic, password);
            if (result == -1)
            {
                String data = "Something went wrong while connecting with the database.";
                return RedirectToAction("Home", "Index", (object)data);
            }

            else if (result == 1)
            {
                String data = "User is Banned";
                return View("Index", "Home", (object)data);
            }
            else if (result == 3||result==5)
            {
                String data = "Incorrect Credentials";

                return RedirectToAction("Index", "Home", (object)data);
            }
            else if (result == 4)
            {
                String data = "Too much wrong Attempts.User banned for 2 Minutes";
                return RedirectToAction("Index","Home", (object)data);
            }
            else 
            {
                Session["cnic"] = cnic;
                List<String> logininfo = CRUD.GetReceiverInfo(cnic);
                ViewBag.info = logininfo;
                TempData["info"] = logininfo;
                return  RedirectToAction("ReceverView");
            }

        }

    }
}