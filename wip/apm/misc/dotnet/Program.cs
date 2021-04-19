using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

using OpenTracing;
using OpenTracing.Util;
using OpenTracing.Tag;

using System.Threading;

namespace myWebApp
{
    public class Program
    {

        public static async Task<int> Main(string[] args)
        {
	    var tracer = GlobalTracer.Instance;
             Console.WriteLine(System.ComponentModel.TypeDescriptor.GetClassName(tracer));
             Console.WriteLine(GlobalTracer.IsRegistered());


	    int x=0;
	    while (x<10000)
            {
		string parentnum = x.ToString();
		string parent = "parent" + parentnum;
            	using (IScope scope = tracer.BuildSpan(parent).WithTag(Tags.SpanKind.Key, Tags.SpanKindServer).StartActive(finishSpanOnDispose: true))
            	{
                	var span = scope.Span;
                	span.SetTag("MyImportantTag", "MyImportantValue");
                	span.Log("My Important Log Statement");
	        x++;
	        Thread.Sleep(50);
		Console.WriteLine(parent);
		var ba = new Uri("http://localhost:5000/");
		var c = new HttpClient { BaseAddress = ba };
		await c.GetAsync("default-handler");
		}
            }
	    Thread.Sleep(2000);
		return 0;
        }

    }
}
