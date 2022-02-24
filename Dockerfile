FROM androidsdk/android-30 AS build
RUN sdkmanager "system-images;android-16;default;armeabi-v7a"
RUN echo "no" | avdmanager create avd -n Android_4.1_API_16 -k "system-images;android-16;default;armeabi-v7a"

FROM ubuntu
RUN apt-get update
RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev lcov
RUN git clone https://github.com/flutter/flutter.git -b stable
RUN export PATH="$PATH:`pwd`/flutter/bin"
RUN flutter precache
RUN flutter doctor
COPY . ./docker_flutter
WORKDIR /docker_flutter
RUN flutter test --coverage
RUN lcov --capture --directory ./coverage --output-file lcov.info



# FROM cirrusci/flutter:dev
# # COPY --from=build . ./bin/emulator
# RUN apt-get update
# RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev lcov
# COPY . ./docker_flutter
# WORKDIR /docker_flutter
# RUN flutter test --coverage
# RUN lcov --capture --directory ./coverage --output-file lcov.info