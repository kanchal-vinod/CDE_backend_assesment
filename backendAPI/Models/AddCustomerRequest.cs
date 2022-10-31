using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace backendAPI.Models
{
    public class AddCustomerRequest
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public Nullable<System.DateTime> CreateOn { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}