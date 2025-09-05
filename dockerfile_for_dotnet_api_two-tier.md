```bash
# Use the official .NET 9 runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 5000
EXPOSE 5001

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
ENV ASPNETCORE_URLS=http://+:5000
ENV ASPNETCORE_ENVIRONMENT=Production

ENTRYPOINT ["dotnet", "two-tier-web-app.dll"]
```