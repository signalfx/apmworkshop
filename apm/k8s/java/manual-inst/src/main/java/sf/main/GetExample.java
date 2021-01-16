package sf.main;

import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.context.Scope;
import io.opentelemetry.extension.auto.annotations.WithSpan;
import io.opentelemetry.api.trace.attributes.SemanticAttributes;

import java.io.IOException;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class GetExample {

  // Instantiate a tracer
  private static final Tracer tracer =
      OpenTelemetry.getGlobalTracer("io.opentelemetry.sf.main.GetExample");

/*
  OkHttpClient client = new OkHttpClient();

  String run(String url) throws IOException {
    Request request = new Request.Builder()
        .url(url)
        .build();

    try (Response response = client.newCall(request).execute()) {
      return response.body().string();
    }
  }
*/

// @WithSpan
public static void wait(int ms)
{
//    Span.setAttribute("withspanpresent", "yes");
    try
    {        Thread.sleep(ms);
    }
    catch(InterruptedException ex)
    {        Thread.currentThread().interrupt();
    }
} // wait

public static void main(String[] args) throws IOException {
  int x = 1;
  while (x>0)
    {

// auto instrumented OKhttp request	    
/*       GetExample okhttpexample = new GetExample();
       String okhttpresponse = okhttpexample.run("http://localhost:5000/echo");
       System.out.println(okhttpresponse);
*/
       System.out.println(x);
       x++;
       wait(250);
       
       // Start a span with scope
       Span manualSpan = tracer.spanBuilder("manualSpan") // operation name
	       .setSpanKind(Span.Kind.SERVER) // tag the span as a service boundary
	       .startSpan();
       try (Scope scope = manualSpan.makeCurrent()) {
         // Add attributes
         manualSpan.setAttribute("my.key", "myvalue");
	 wait(10);
         } finally {
         // End span
         manualSpan.end();
	 } // finally
      // End manual span stanza

      } // while loop
  } // main

} // class
