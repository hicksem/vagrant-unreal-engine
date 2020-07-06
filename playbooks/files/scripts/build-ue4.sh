#!/bin/bash
#
# Building UE4 on Linux from source
#
# https://docs.unrealengine.com/en-US/Platforms/Linux/BeginnerLinuxDeveloper/SettingUpAnUnrealWorkflow/index.html

cd ~

UNREAL_ENGINE_VERSION=4.24

# Download source code
if [ ! -d "./UnrealEngine" ]; then
    printf "\n\n===== Cloning repo =====\n"
    git clone git@github.com:EpicGames/UnrealEngine.git -b "$UNREAL_ENGINE_VERSION"
fi

cd ./UnrealEngine

printf "\n\n===== Setting up files =====\n"

# Setup the files need to generate the project files.
./Setup.sh

printf "\n\n===== Generating project files =====\n"

# Generates your project files.
./GenerateProjectFiles.sh

printf "\n\n===== Making source built engine =====\n"
printf "\nBe patient.  This can take between 10 mins and an hour.\n"

# Makes the build.
make
