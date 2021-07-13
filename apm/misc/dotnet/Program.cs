using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net;

namespace HTTP_Test
{
    class program
    {
        static void Main()
        {   for(int i = 0; i < 10; i++)
            {
                Task t = new Task(HTTP_GET);
                // t.Start();
                t.RunSynchronously();
                t.Wait();
                // Console.ReadLine();
            }
        }

        static async void HTTP_GET()
        {
            var TARGETURL = "https://github.com/";

            // HttpClientHandler handler = new HttpClientHandler()
            // {
            //     Proxy = new WebProxy("http://127.0.0.1:8888"),
            //     UseProxy = false,
            // };

            Console.WriteLine("GET: + " + TARGETURL);

            // ... Use HttpClient.            
            HttpClient client = new HttpClient();

            // var byteArray = Encoding.ASCII.GetBytes("username:password1234");
            // client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            HttpResponseMessage response = await client.GetAsync(TARGETURL);
            HttpContent content = response.Content;

            // ... Check Status Code                                
            Console.WriteLine("Response StatusCode: " + (int)response.StatusCode);

            // sleep 100 ms
            Thread.Sleep(100);

            // ... Read the string.
            // string result = await content.ReadAsStringAsync();

            // ... Display the result.
            // if (result != null &&
            // result.Length >= 50)
            // {
            //     Console.WriteLine(result.Substring(0, 50) + "...");
            // }
        }
    }
}