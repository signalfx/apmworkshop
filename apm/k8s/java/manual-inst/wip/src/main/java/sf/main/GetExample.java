package sf.main;

import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.context.Scope;
import io.opentelemetry.api.trace.attributes.SemanticAttributes;

import io.opentelemetry.api.common.Attributes;
import io.opentelemetry.context.Context;

import java.util.Random; 
import java.io.IOException;

public class GetExample {

TracerProvider tracerProvider =
    OpenTelemetry.getGlobalTracerProvider();

private static final Tracer tracer =
    tracerProvider.getTracer("io.opentelemetry.sf.main.GetExample");		

private static void wait(int ms)
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

  Random random = new Random();
  int val = random.nextInt();
  String userID = new String();
  userID = Integer.toHexString(val);

  while (x>0)
    {
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
         manualSpan.setAttribute("user.ID", userID);
         } finally {
         // End span
         manualSpan.end();
	 } // finally
      // End manual span stanza

    } // while loop

  } // main

} // class
