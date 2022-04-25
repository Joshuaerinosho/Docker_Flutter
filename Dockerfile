
FROM cirrusci/flutter:latest

RUN apt-get install -y --no-install-recommends sudo lcov
COPY ./src ./docker_flutter
WORKDIR /docker_flutter

#Install Android SDK
RUN y | sudo apt update && sudo apt install android-sdk

#Add CLI Tools to Path
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"

#Create a variable for the Android SDK path
ENV ANDROID_SDK_ROOT /usr/lib/android-sdk

#Add Emulator to Path
ENV PATH="$PATH:$ANDROID_SDK_ROOT/emulator"

#Accept all licenses
RUN yes | sdkmanager --licenses

## Download an ARM system image to create an ARM emulator.
RUN sdkmanager "system-images;android-25;google_apis;armeabi-v7a"

RUN sdkmanager "system-images;android-16;default;armeabi-v7a"

RUN flutter doctor
