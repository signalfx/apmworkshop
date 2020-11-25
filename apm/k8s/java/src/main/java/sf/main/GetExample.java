package sf.main;

import java.io.IOException;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class GetExample {
  OkHttpClient client = new OkHttpClient();

  String run(String url) throws IOException {
    Request request = new Request.Builder()
        .url(url)
        .build();

    try (Response response = client.newCall(request).execute()) {
      return response.body().string();
    }
  }
  
public static void wait(int ms)
{
    try
    {        Thread.sleep(ms);
    }
    catch(InterruptedException ex)
    {        Thread.currentThread().interrupt();
    }
} // wait

public static void main(String[] args) throws IOException {
  int x = 1;
  while (x <= 100000 )
    {
       GetExample okhttpexample = new GetExample();
       String okhttpresponse = okhttpexample.run("https://api.github.com");
       System.out.println(okhttpresponse);
       System.out.println(x);
       x++;
       wait(250);
      } // while loop

  } // main

} // class
