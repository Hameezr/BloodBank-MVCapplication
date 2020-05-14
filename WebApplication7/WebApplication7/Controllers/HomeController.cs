using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using db_connectivity.Models;
namespace db_connectivity.Controllers
{
    public class HomeController : Controller
    {
        int result;
        static string data = "";
        static String cnic1;
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult authenticateLogin(String cnic, String password)
        {
            result = CRUD.Login(cnic, password);

            if (result == -1)
            {
                String data = "Something went wrong while connecting with the database.";
                return View("Index", (object)data);
            }
            else if (result == 1)
            {

                String data = "Use";
                return View("Index", (object)data);
            }
            Session["cnic"] = cnic;
            var cookie = new HttpCookie("cnic");
            cookie.Value = cnic;
            Response.Cookies.Add(cookie);
            cnic1 = cnic;
            return RedirectToAction("homePage");

        }

        public ActionResult Signup()
        {

            return View();
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult updateCnic(String  oldCnic,String newCnic)
        {
           
            if (Request.Cookies["cnic"].Value == Session["cnic"].ToString())
            {
                result = CRUD.updateCnic(newCnic, oldCnic);
                // result = CRUD.updateCnic(newcnic, oldcnic);
                if (result == 1)
                {
                    String data = "couldnot find update";
                    //  return View("homePage", (object)data);
                    return View("Login", (object)data);
                }
                else if (result == -1)
                {
                    String data = "Something went wrong while connecting with the database.";
                    return View("Login", (object)data);
                }
                else
                    return RedirectToAction("Login");
                //return View("Login");
            }
            else
            {
                 return View("Login");

            }
        }


        public ActionResult donorMsg(String cnic, String msg)
        {
            String msg1 = msg;
            return View();

        }


        public ActionResult updateName(String oldCnic, String name)
        {
            result = CRUD.updateName(name, oldCnic);
            if (Request.Cookies["cnic"].Value == Session["cnic"].ToString())
            {

                // result = CRUD.updateCnic(newcnic, oldcnic);
                if (result == 1)
                {
                    String data = "couldnot find ur cnic";
                    //  return View("homePage", (object)data);
                    return View("Login", (object)data);
                }
                else if (result == -1)
                {
                    String data = "Something went wrong while connecting with the database.";
                    return View("Login", (object)data);
                }
                else
                     return RedirectToAction("homePage");
                    //return View("Login");
            }
            else
            {
                return RedirectToAction("Login");

            }
        }
        public ActionResult ReceiverView(String cnic,String password, String btype, String city, String block)
        {
           ViewBag.viewcnic = cnic;
            ViewBag.viewpass = password;

            result = CRUD.Login(cnic, password);

            if (result == -1)
            {
                String data = "Something went wrong while connecting with the database.";
                return RedirectToAction("Index",(object)data);
            }

            else if (result == 1)
            {

                String data = "Incorrect Credentials";
                return RedirectToAction("Index", (object)data);
            }
            Session["cnic"] = cnic;


         
            List<List<List<String>>> DonAndBBavailable = CRUD.getSearch(cnic, btype, city, block);
            try
            {
                if (Session["cnic"].ToString()!="")
                {
                    //return RedirectToAction()
                    return View(DonAndBBavailable);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch
            {
                return RedirectToAction("Index");
            }

        }
        ////////////////////DOnor signup
        public ActionResult authenticatesignup(String cnic,String password, String name,String age, String phoneno,String block,String city,String add,String bloodtype,String newpass)
        {
            result = CRUD.SignUp2(cnic,password, name,age,phoneno,block,city,add,bloodtype);

            if (result == -1)
            {
                String data = "Something went wrong while connecting with the database.";
                return View("Login", (object)data);
            }
            else if (result == 1)
            {

                String data = "Incorrect cnic";
                return View("Login", (object)data);
            }
            else if (result == 2)
            {

                String data = "Incorrect age";
                return View("Login", (object)data);
            }
            else if (result == 3)
            {

                String data = "Incorrect bloodtype";
                return View("Login", (object)data);
            }

           
            return RedirectToAction("Index");

        }
        public ActionResult homePage()
        {

            try
            {
                if (Request.Cookies["cnic"].Value == Session["cnic"].ToString())
                {
                    List<string> users = CRUD.getUsers(cnic1);
                    if (users == null)
                    {
                        RedirectToAction("Signup");
                    }

                    Console.Write(users);
                    return View(users);
                }
                else
                {
                    return RedirectToAction("Login");
                }
            }
            catch
            {
                return RedirectToAction("Login");
            }




            
            
            
        }
        /////////////////////////////////////////////////////////////////////////////////////
        ///////////////RECEIVER//////////////
        public ActionResult ReceiverSignup(string cnic, string password, string address, string pno, string name, string newpass)
        {
            
            result = CRUD.RecSignUp(cnic, password, name, pno, address);
            if (result == -1)
            {
                data = "unable to connect to database";
                return View("Index", (object)data);
            }
            else if (result == 1)
            {
                data = "cnic/phone Number not valid";
                return View("Index", (object)data);
            }   
            data = "sign up successful";
            ViewBag.loginstatus = data;
            
            
            return View("Index", (object)data);

        }
    }
}