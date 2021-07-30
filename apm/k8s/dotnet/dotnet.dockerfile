FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY bin/Release/net5.0/publish/ App/
COPY signalfx-dotnet-tracing_0.1.12_amd64.deb App/
COPY run-client.sh /App
WORKDIR /App
RUN dpkg -i signalfx-dotnet-tracing_0.1.12_amd64.deb
ENV DOTNET_EnableDiagnostics=0
# ENTRYPOINT ["dotnet", "myApp.dll"]