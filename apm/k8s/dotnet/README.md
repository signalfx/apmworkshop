.NET CORE example uses the .NET http client to get non-responding URL so makes valid traces with 403 status code

It was containerized with these [instructions from Microsoft](https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows)

For .NET Core 5:  

Deploy:  
`source deploy-client.sh`

Remove the container:
`source delete-all.sh`

.NET Core 2.1 [located here](../../misc/dotnet-2.1)