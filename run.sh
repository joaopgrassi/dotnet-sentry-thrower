#!/bin/bash
set -e

if [ "$1" != "--no-build" ]; then
    message=$1
    rm -rf bin/Release
    rm -rf ~/.nuget/packages/sharpraven
    dotnet restore --ignore-failed-sources
    dotnet build -c Release
else
    message=$2
fi

set +e

for throwerPathDll in bin/Release/*/CoreThrower.dll; do
    [ -e "$throwerPathDll" ] || continue
    printf "\nRunning: $throwerPathDll\n"
    dotnet $throwerPathDll $message
done
for throwerPathExe in bin/Release/*/CoreThrower.exe; do
    [ -e "$throwerPathExe" ] || continue
    printf "\nRunning: $throwerPathExe\n"
    mono $throwerPathExe $message
done
