using System;
using System.Collections.Generic;
using Couchbase.Core;
using Couchbase.Extensions.DependencyInjection;
using Couchbase.N1QL;
using Microsoft.AspNetCore.Mvc;

namespace QuickStart.Controllers
{
    [ApiController]
    public class UserController : ControllerBase
    {
        // tag::ctor[]
        private readonly IBucket _bucket;

        public UserController(IBucketProvider bucketProvider)
        {
            _bucket = bucketProvider.GetBucket("default");
        }
        // end::ctor[]

        // tag::getdata[]
        [HttpGet]
        [Route("/")]
        public List<User> GetUserByEmail(string email)
        {
            var n1ql = "SELECT d.* FROM default d WHERE d.email = $email";
            var query = QueryRequest.Create(n1ql);
            query.AddNamedParameter("$email", email);
            var result = _bucket.Query<User>(query);
            return result.Rows;
        }
        // end::getdata[]

        // tag::insert[]
        [HttpPost]
        [Route("/")]
        public string InsertUser(User user)
        {
            var key = Guid.NewGuid().ToString();
            _bucket.Insert(key, user);
            return "Inserted user with ID: " + key;
        }
        // end::insert[]
    }
}
