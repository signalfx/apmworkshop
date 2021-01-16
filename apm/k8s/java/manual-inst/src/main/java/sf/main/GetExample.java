package sf.main;

import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.context.Scope;
import io.opentelemetry.api.trace.attributes.SemanticAttributes;

import java.io.IOException;

public class GetExample {

// Instantiate a tracer
private static final Tracer tracer =
    OpenTelemetry.getGlobalTracer("io.opentelemetry.sf.main.GetExample");	

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
	 wait(10);
         } finally {
         // End span
         manualSpan.end();
	 } // finally
      // End manual span stanza

    } // while loop

  } // main

} // class
