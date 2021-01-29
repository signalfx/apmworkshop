package sf.main;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.context.Scope;
import io.opentelemetry.extension.annotations.WithSpan;

public class GetExample {

  // Instantiate a tracer. Since we're using the opentelemetry auto-instrumentation agent,
  // we can be sure that the agent will have set up the SDK for us and it should be ready to use.
  private static final Tracer tracer =
      GlobalOpenTelemetry.getTracer("io.opentelemetry.sf.main.GetExample");

  public static void main(String[] args) {
    int x = 1;
    while (x < Integer.MAX_VALUE) {
      System.out.println(x);
      x++;
      fullyManualInstrumentation();
    } // while loop
  } // main

  private static void wait(int ms) {
    try {
      Thread.sleep(ms);
    } catch (InterruptedException ex) {
      Thread.currentThread().interrupt();
    }
  }

  private static void fullyManualInstrumentation() {
    Span exampleSpan = tracer.spanBuilder("exampleSpan") // operation name
        .setSpanKind(Span.Kind.SERVER) // tag the span as a service boundary
        .startSpan();
    // Put the span into the current context
    try (Scope scope = exampleSpan.makeCurrent()) {
      // Add attributes
      exampleSpan.setAttribute("my.key", "myvalue");
      exampleSpan.setAttribute("service.name", "someotherservice");
      exampleSpan.addEvent("MyEvent");
      //simulate some work
      doSomeWork();
    } finally {
      // Always end the span in a finally block.
      exampleSpan.end();
    }
  }

  //the agent will automatically create a span for you and put it into the current Context.
  @WithSpan
  private static void doSomeWork() {
    Span.current().addEvent("starting sleep");
    wait(250);
    Span.current().addEvent("stopping sleep");
  }
}
