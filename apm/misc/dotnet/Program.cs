using System;
using System.Threading;
using System.Threading.Tasks;
using System.Net.Http;

namespace HTTP_Test
{
    class program
    {
        static void Main()
        {   while(true)
            {
                Task t = new Task(HTTP_GET);
                t.RunSynchronously();
                t.Wait();
                // sleep 
                Thread.Sleep(500);
            }
        }

        static async void HTTP_GET()
        {
            var TARGETURL = "https://api.github.com/";

            Console.WriteLine("GET: + " + TARGETURL);

            // ... Use HttpClient.            
            HttpClient client = new HttpClient();
            HttpResponseMessage response = await client.GetAsync(TARGETURL);
            HttpContent content = response.Content;

            // ... Check Status Code                                
            Console.WriteLine("Response StatusCode: " + (int)response.StatusCode);
        }
    }
}