## .NET Core Linux Tracing Example

#### **Requirements**

For this workshop you must have the following installed:

1. Linux system

2. Signalfx Account

3. Complete .NET installation of all components as shown here: https://docs.microsoft.com/en-us/dotnet/core/install/

4. Configuration of SignalFx SmartAgent for uAPM as shown here: https://docs.signalfx.com/en/latest/apm2/apm2-getting-started/apm2-smart-agent.html

   1. Ensure that you can see your host in the SignalFx dashboard and that the YAML values required for tracing as shown above are correct before proceeding

5. Installation of SignalFx .NET instrumentation components as shown here: https://github.com/signalfx/signalfx-dotnet-tracing

   1. Pay close attention to the environment variables and make sure that the examples below are run with environment variables set correctly:

   2. When following the repo above, set the SignalFx Endpoint URL to Localhost instead of <MyAgentorGateway>

      1. ```
         export SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace
         ```

#### Overview

This example will execute two tasks:

#1 Run the default .NET ASP web server on port 5000

#2 Run an example .NET program that builds traces based on use of HTTPCLIENT framework hitting the web server running from step #1

And we will verify that traces are being sent via the SignalFx Smart Agent and dasbhoard.

#### Step 1: Install And Run .NET ASP Web Server

Choose a directory outside of this repo i.e. ~ and execute the following steps:

`cd ~`

`dotnet new webApp -o myWebApp --no-https`

`cd myWebApp`

`dotnet run`

This will create a web server running on port 5000

#### Step 2: Run the .NET Trace Builder From This Repo

In a separate command line on your linux server, in the directory of this repo:

Ensure that the environment variables from step 4 are visible by typing ` env` and verify that you see the variables set in Step 4 above. If you don't see them, re-do step 4 above.

Then run the trace builder from this repo in the same directory as the `Program.cs` and `myApp.csproj`:

`dotnet run`

This will execute a loop slowly building 10,000 parent spans. These will appear as separate service endpoints in the SignalFx APM dashboard but you can look at the `MyCoreService` service dashboard and see trace count metrics correctly.

#### Step 3: Check SignalFx Agent Status To Verify Traces Are Being Sent

`signalfx agent status`


#### Step 4: End Example

`Ctrl-c` out of each running process (web server and trace builder) to halt each.
