using backendAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace backendAPI.Controllers
{
    public class CustomerController : Controller
    {
        //database connection
        private DCE_customerEntities db = new DCE_customerEntities();




        //POST:Customer
        public string createCustomer(AddCustomerRequest addCustomerRequest)
        {
            var customer = new Customer()
            {

                UserId = Guid.NewGuid(),
                Username = addCustomerRequest.Username,
                Email = addCustomerRequest.Email,
                FirstName = addCustomerRequest.FirstName,
                LastName = addCustomerRequest.LastName,
                CreateOn = addCustomerRequest.CreateOn,
                IsActive = addCustomerRequest.IsActive

            };

            db.Customers.Add(customer);
            db.SaveChanges();
            return "customer created";

        }

        // GET: Customer
        public IEnumerable<Customer> getCustomers()
        {


            return db.Customers.ToList();

        }



        // update: Customer
        public string updateCustomer(Guid id, [FromBody] Customer customer)
        {


            var entity = db.Customers.FirstOrDefault(e => e.UserId == id);
            entity.Username = customer.Username;
            entity.Email = customer.Email;
            entity.FirstName = customer.FirstName;
            entity.LastName = customer.LastName;
            entity.CreateOn = customer.CreateOn;
            entity.IsActive = customer.IsActive;

            db.SaveChanges();

            return "customer updated";

        }


        // delete Customer
        public string deleteCustomer(Guid id)
        {



            var customer_ = db.Customers
                .Where(s => s.UserId == id)
                .FirstOrDefault();

            db.Entry(customer_).State = System.Data.Entity.EntityState.Deleted;
            db.SaveChanges();


            return "customer deleted";
        }
    }
}