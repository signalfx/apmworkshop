.net example uses the .net http client to get non-responding URL so makes valid traces with 403 status code

It was built with these [instructions from microsoft](https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows)

For .net 5:  

Deploy:  
`source deploy-client.sh`

Remove the container:
`source delete-all.sh`

.net 2.1 [located here](../../misc/dotnet-2.1)