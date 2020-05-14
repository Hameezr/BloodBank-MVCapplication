using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;

namespace db_connectivity.Models
{
    public class CRUD
    {
        public static string connectionString = "data source=DESKTOP-1BDK1I5; Initial Catalog=BloodforLife;Integrated Security=true";

        public static List<string> GetReceiverInfo(string cnic)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
             List<String> ll = new List<string>();
            
            SqlDataReader reader = null;
            try
            {
                cmd = new SqlCommand("getRecInfo", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
               


                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                reader = cmd.ExecuteReader();
               
                while (reader.Read())
                {
                    for (int i = 0; i < 6; i++)
                    {
                        if(i!=1)
                        ll.Add(reader[i].ToString());
                    }
                }
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);

            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return ll;
        }


        public static List<string> GetDonInfo(string cnic)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            List<String> ll = new List<string>();

            SqlDataReader reader = null;
            try
            {
                cmd = new SqlCommand("getDonInfo", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);

                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                reader = cmd.ExecuteReader();

                reader.Read();
                  
                ll.Add(reader[0].ToString());
                ll.Add(reader[2].ToString());
                ll.Add(reader[4].ToString());
                ll.Add(reader[7].ToString());
                ll.Add(reader[5].ToString());
                ll.Add(reader[6].ToString());
                ll.Add(reader[3].ToString());
                ll.Add(reader[11].ToString());
                ll.Add(reader[8].ToString());

            
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);

            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return ll;
        }


        public static int Login(string cnic, string password)    //donor login
        {

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("checkDonLoginAttempts", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                   cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                cmd.Parameters.Add("@password", SqlDbType.NVarChar, 50).Value = password;


                cmd.Parameters.Add("@result", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@result"].Value);

            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;

        }   //Donor login

        public static int SignUp1(string userId, string password)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            try
            {
                cmd = new SqlCommand("UserSignupProc1", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                
                cmd.Parameters.Add("@userId", SqlDbType.NVarChar, 50).Value = userId;
                cmd.Parameters.Add("@password", SqlDbType.NVarChar, 50).Value = password;


                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;
        }

        public static int RecLogin(string cnic, string password)
        {

            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;

            try
            {
                cmd = new SqlCommand("checkRecLoginAttempts", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                cmd.Parameters.Add("@password", SqlDbType.NVarChar, 50).Value = password;


                cmd.Parameters.Add("@result", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@result"].Value);



            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;

        }
       
        public static int updateCnic(String newcnic,String oldcnic)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            try
            {
                cmd = new SqlCommand("updateCnic", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@oldcnic", SqlDbType.NVarChar, 50).Value =System.Convert.ToInt64(oldcnic) ;
                cmd.Parameters.Add("@newcnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(newcnic);


                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;


        }

        public static int updateName(String name, String oldcnic)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            try
            {
                cmd = new SqlCommand("updateDonName", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@oldcnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(oldcnic);
                cmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name;


                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;


        }

        public static List<String> getUsers(String cnic)
        {
            
            //List<List<String>> biglist = new List<List<String>>();
            List<String> ll = new List<string>(14);
            
            SqlDataReader reader = null;
            String queryString = "select * from Donor where cnic="+ System.Convert.ToInt64(cnic);

            SqlConnection con = new SqlConnection(connectionString);

            SqlCommand cmd = new SqlCommand(queryString, con);

            try
            {

                con.Open();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ll = new List<String>();
                    for (int i = 0; i < 9; i++)
                    {
                        if(i!=1)
                        ll.Add(reader[i].ToString());
                    }
                  //  biglist.Add(ll);
                }
            }

            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                return null;
            }
            finally
            {
                con.Close();
            }
            return ll;

        }

        public static List<List<List<String>>> getSearch(String cnic,String btype,String city,String block)
        {
            SqlDataReader reader = null;
            List<String> ll = new List<string>(14);
            List<List<String>> biglist = new List<List<String>>();
           List< List<List<String>>> combinedlist = new List<List<List<String>>>();
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            int result1 = 0;
            try
            {
                cmd = new SqlCommand("authRecSearchHist", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                cmd.Parameters.Add("@bloodtype", SqlDbType.NVarChar, 50).Value =btype;
                cmd.Parameters.Add("@city", SqlDbType.NVarChar, 50).Value = city;
                cmd.Parameters.Add("@block", SqlDbType.NVarChar, 50).Value = block;



                cmd.Parameters.Add("@moutput", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@moutput2", SqlDbType.Int).Direction = ParameterDirection.Output;
                // cmd.ExecuteNonQuery();
                reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ll = new List<String>();
                    for (int i = 0; i < 6; i++)
                    {  
                            ll.Add(reader[i].ToString());
                    }
                    biglist.Add(ll);
                }
                result = Convert.ToInt32(cmd.Parameters["@moutput"].Value);
                if (result == 0 || result == 2)
                {
                    reader.Close();
                    combinedlist.Add(biglist);
                    biglist = new List<List<String>>();
                    cmd = new SqlCommand("authRecSearchHistDoner", con);

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                    cmd.Parameters.Add("@bloodtype", SqlDbType.NVarChar, 50).Value = btype;
                    cmd.Parameters.Add("@city", SqlDbType.NVarChar, 50).Value = city;
                    cmd.Parameters.Add("@block", SqlDbType.NVarChar, 50).Value = block;



                    cmd.Parameters.Add("@moutput", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("@moutput2", SqlDbType.Int).Direction = ParameterDirection.Output;
                   
                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ll = new List<String>();
                        for (int i = 0; i < 3; i++)
                        {
                            ll.Add(reader[i].ToString());
                        }
                        biglist.Add(ll);
                    }
                    result = Convert.ToInt32(cmd.Parameters["@moutput"].Value);
                    if (result == 0 || result == 2)
                        combinedlist.Add(biglist);
                    else
                        return null;

                }
                else
                {
                    return null;

                }
                
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return combinedlist;
        }







        public static int SignUp2(String cnic,String password, String name, String age, String phoneno, String block, String city, String address, String bloodtype)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            try
            {
                cmd = new SqlCommand("signup", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                cmd.Parameters.Add("@password", SqlDbType.NVarChar, 50).Value = password;
                cmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name;
                cmd.Parameters.Add("@age", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt32(age);
                cmd.Parameters.Add("@phoneno", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(phoneno);
                cmd.Parameters.Add("@block", SqlDbType.NVarChar, 50).Value = block;
                cmd.Parameters.Add("@city", SqlDbType.NVarChar, 50).Value = city;
                cmd.Parameters.Add("@add", SqlDbType.NVarChar, 50).Value = address;
                cmd.Parameters.Add("@bloodtype", SqlDbType.NVarChar, 50).Value = bloodtype;


                cmd.Parameters.Add("@status", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@status"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;
        }

        public static int RecSignUp(String cnic, String password, String name, String phoneno,  String address)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd;
            int result = 0;
            try
            {
                cmd = new SqlCommand("RecSignup", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@cnic", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(cnic);
                cmd.Parameters.Add("@password", SqlDbType.NVarChar, 50).Value = password;
                cmd.Parameters.Add("@name", SqlDbType.NVarChar, 50).Value = name;
              
                cmd.Parameters.Add("@phoneno", SqlDbType.NVarChar, 50).Value = System.Convert.ToInt64(phoneno);
               
                cmd.Parameters.Add("@address", SqlDbType.NVarChar, 50).Value = address;
              


                cmd.Parameters.Add("@output", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                result = Convert.ToInt32(cmd.Parameters["@output"].Value);
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
                result = -1; //-1 will be interpreted as "error while connecting with the database."
            }
            finally
            {
                con.Close();
            }
            return result;
        }

    }
}