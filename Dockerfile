FROM cirrusci/flutter:latest

RUN apt-get install -y lcov

## Download an ARM system image to create an ARM emulator.
RUN sdkmanager "system-images;android-25;google_apis;armeabi-v7a"

RUN sdkmanager "system-images;android-16;default;armeabi-v7a"

RUN flutter doctor
