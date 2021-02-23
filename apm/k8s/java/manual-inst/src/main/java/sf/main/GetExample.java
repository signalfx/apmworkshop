package sf.main;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.context.Scope;
import io.opentelemetry.extension.annotations.WithSpan;

import java.util.Random;

public class GetExample {

  // Instantiate a tracer. Since we're using the opentelemetry auto-instrumentation agent,
  // we can be sure that the agent will have set up the SDK for us and it should be ready to use
  private static final Tracer tracer =
      GlobalOpenTelemetry.getTracer("io.opentelemetry.sf.main.GetExample");

  public static void main(String[] args) {
    int x = 1;
    while (x < Integer.MAX_VALUE) {
      System.out.println("Loop: " + x);
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
  } //wait

  private static void fullyManualInstrumentation() {
    Span exampleSpan = tracer.spanBuilder("exampleSpan") // operation name
        .setSpanKind(Span.Kind.SERVER) // tag the span as a service boundary
        .startSpan();
    
    Random random = new Random(); 	   
    int val = random.nextInt();
    String userID = new String();
    userID = Integer.toHexString(val);
    System.out.println("userID: " + userID);

    // Put the span into the current context
    try (Scope scope = exampleSpan.makeCurrent()) {
      // Add attributes
      exampleSpan.setAttribute("my.key", "myvalue");
      exampleSpan.setAttribute("user.id", userID);
      exampleSpan.setAttribute("service.name", "someotherservice");
      exampleSpan.addEvent("MyEvent");
      //simulate some work and annotate the function with spans using @WithSpan
      annotateSpanFunc();
    } finally {
      // Always end the span in a finally block.
      exampleSpan.end();
    }
  }

  //the agent will automatically create a span for you and put it into the current Context.
  @WithSpan
  private static void annotateSpanFunc() {
    Span.current().addEvent("starting sleep");
    Random random = new Random();
    int randsleep = random.nextInt(250);
    wait(randsleep);
    Span.current().addEvent("stopping sleep");
  } //annotateSpanFunc
} //class
