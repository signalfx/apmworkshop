FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY bin/Release/net5.0/publish/ App/
COPY signalfx-dotnet-tracing* App/
COPY run-client.sh /App
WORKDIR /App
RUN dpkg -i signalfx-dotnet-tracing_0.1.13_amd64.deb
RUN mkdir /opt/tracelogs
# ENV DOTNET_EnableDiagnostics=0
# ENTRYPOINT ["dotnet", "myApp.dll"]