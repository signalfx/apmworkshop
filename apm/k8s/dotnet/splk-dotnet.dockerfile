FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
RUN mkdir /home/code
WORKDIR /home/code
COPY . /home/code/
RUN dpkg -i signalfx-dotnet-tracing_0.1.12_amd64.deb

# apt install -y dnsutils && \
# apt install -y util-linux && \
# apt install -y coreutils && \