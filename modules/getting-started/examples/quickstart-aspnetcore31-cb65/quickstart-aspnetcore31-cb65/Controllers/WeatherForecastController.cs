﻿using System;
using System.Linq;
using Couchbase.Core;
using Couchbase.Extensions.DependencyInjection;
using Couchbase.N1QL;
using Microsoft.AspNetCore.Mvc;

namespace QuickStart.Controllers
{
    [ApiController]
    public class WeatherForecastController : ControllerBase
    {
        // tag::ctor[]
        private readonly IBucket _bucket;

        public WeatherForecastController(IBucketProvider bucketProvider)
        {
            _bucket = bucketProvider.GetBucket("default");
        }
        // end::ctor[]

        // tag::getdata[]
        [HttpGet]
        [Route("/")]
        public WeatherForecast GetData(string id = null)
        {
            var n1ql = "SELECT w.* FROM default w WHERE META(w).id = $id";
            var query = QueryRequest.Create(n1ql);
            query.AddNamedParameter("$id", id);
            var result = _bucket.Query<WeatherForecast>(query);
            return result.Rows.FirstOrDefault();
        }
        // end::getdata[]

        // tag::insert[]
        [HttpPost]
        [Route("/")]
        public string InsertData(WeatherForecast forecast)
        {
            var key = Guid.NewGuid().ToString();
            _bucket.Insert(key, forecast);
            return "Inserted forecast with ID: " + key;
        }
        // end::insert[]
    }
}
