
FROM cirrusci/flutter:latest

RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev sudo lcov
COPY ./src ./docker_flutter
WORKDIR /docker_flutter

#Install Android SDK
RUN sudo apt-get install android-sdk --assume-yes

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
