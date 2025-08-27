```bash
# Use the official .NET 9 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build

# create a folder where the app will be stored.
WORKDIR /app

# Copy the source code from your local machine to the container.
COPY . ./

# Restore project dependencies.
RUN dotnet restore MyConsoleApp.csproj

# Publish the project in Release mode to the /out folder.
RUN dotnet publish MyConsoleApp.csproj -c Release -o out

# Use a smaller .NET 9 Runtime image for running the app.
FROM mcr.microsoft.com/dotnet/runtime:9.0-preview

WORKDIR /app

# Copy published files from the build stage to this image.
COPY --from=build /app/out ./

# Set the entrypoint to run the app using dotnet.
ENTRYPOINT ["dotnet", "MyConsoleApp.dll"]
```