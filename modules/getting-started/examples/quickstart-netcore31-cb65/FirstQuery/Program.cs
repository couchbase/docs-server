using System;
using System.Collections.Generic;
using System.Linq;
using Couchbase;
using Couchbase.Configuration.Client;
using Couchbase.Linq;

namespace FirstQuery
{
    class Program
    {
        static void Main(string[] args)
        {
            // tag::clusterSetup[]
            var cluster = new Cluster(new ClientConfiguration {
                Servers = new List<Uri> { new Uri("http://localhost:8091")}
            });
            cluster.Authenticate("Administrator", "password");
            var bucket = cluster.OpenBucket("default");
            // end::clusterSetup[]

            // tag::linqSetup[]
            var context = new BucketContext(bucket);
            // end::linqSetup[]

            // tag::upserts[]
            var user00001 = new User {
                Email = "perry.mason@acme.com",
                FirstName = "Perry",
                LastName = "Mason",
                TagLine = "Who can we get on the case?"
            };
            var user00002 = new User {
                Email = "major.tom@acme.com",
                FirstName = "Major",
                LastName = "Tom",
                TagLine = "Send me up a drink"
            };
            var user00003 = new User {
                Email = "jerry.wasaracecardriver@acme.com",
                FirstName = "Jerry",
                LastName = "Wasaracecardriver",
                TagLine = "el sob number one"
            };                             
            bucket.Upsert("USER::00001", user00001);
            bucket.Upsert("USER::00002", user00002);
            bucket.Upsert("USER::00003", user00003);
            // end::upserts[]

            // tag::linq[]
            var results = context.Query<User>().Where(u => u.FirstName == "Perry");

            foreach(var result in results)
            {
                Console.WriteLine($"{result.FirstName} {result.LastName} {result.Email}");
                Console.WriteLine($"{result.TagLine}");
                Console.WriteLine();
            }
            // end::linq[]

            cluster.Dispose();
        }
    }

    // tag::user[]
    public class User
    {
        public string Email {get;set;}
        public string FirstName {get;set;}
        public string LastName {get;set;}
        public string TagLine {get;set;}
        public string Type {get;} = "user";
    }
    // end::user[]
}
