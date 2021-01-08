package sf.main;

import java.io.IOException;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.StatusCode;
import io.opentelemetry.api.trace.Tracer;
import io.opentelemetry.api.trace.attributes.SemanticAttributes;
import io.opentelemetry.api.trace.propagation.W3CTraceContextPropagator;
import io.opentelemetry.context.Context;
import io.opentelemetry.context.Scope;
import io.opentelemetry.context.propagation.ContextPropagators;
import io.opentelemetry.context.propagation.TextMapPropagator;
import io.opentelemetry.exporter.logging.LoggingSpanExporter;
import io.opentelemetry.sdk.OpenTelemetrySdk;
import io.opentelemetry.sdk.trace.SdkTracerProvider;
import io.opentelemetry.sdk.trace.export.SimpleSpanProcessor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;

public class GetExample {

  private static final LoggingSpanExporter loggingExporter = new LoggingSpanExporter();
  private static final OpenTelemetry openTelemetry = initOpenTelemetry(loggingExporter);
  private static final Tracer tracer = openTelemetry.getTracer("io.opentelemetry.example.http.HttpClient");
    private static OpenTelemetry initOpenTelemetry(LoggingSpanExporter loggingExporter) {
    // install the W3C Trace Context propagator
    // Get the tracer management instance
    SdkTracerProvider sdkTracerProvider = SdkTracerProvider.builder().build();
    // Set to process the the spans by the LogExporter
    sdkTracerProvider.addSpanProcessor(SimpleSpanProcessor.builder(loggingExporter).build());

    return OpenTelemetrySdk.builder()
        .setTracerProvider(sdkTracerProvider)
        .setPropagators(ContextPropagators.create(W3CTraceContextPropagator.getInstance()))
        .build();
  }

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

  private static void sampleTrace() {
    Span span = tracer.spanBuilder("/").setSpanKind(Span.Kind.CLIENT).startSpan();
    try (Scope scope = span.makeCurrent()) {
      span.setAttribute("http.method", "GET");
      span.setAttribute("http.url", "mymadeupthing.com");
      span.addEvent("Init");
      wait(250);
      span.addEvent("End");
    } finally {
      span.end();
    }

  }

  public static void main(String[] args) throws IOException {
    int x = 1;
    //  Tracer tracer =   openTelemetry.getTracer("","");
    while (x <= 100000 )
    {
       sampleTrace();
       GetExample okhttpexample = new GetExample();
       String okhttpresponse = okhttpexample.run("http://localhost:5000/echo");
       System.out.println(okhttpresponse);
       System.out.println(x);
       x++;
       wait(250);
    } // while loop

  } // main

} // class
