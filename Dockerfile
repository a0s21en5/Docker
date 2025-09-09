# Use the official .NET 9 runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Use the .NET 9 SDK for building
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["two-tier-web-app.csproj", "./"]
RUN dotnet restore "two-tier-web-app.csproj"

# Copy the rest of the source code
COPY . .

# Build the application
RUN dotnet build "two-tier-web-app.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "two-tier-web-app.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final stage: create the runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .



# Set environment variables for ASP.NET Core
ENV ASPNETCORE_URLS=http://+:80
ENV ASPNETCORE_ENVIRONMENT=Development

ENTRYPOINT ["dotnet", "two-tier-web-app.dll"]
