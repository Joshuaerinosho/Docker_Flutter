FROM androidsdk/android-30
RUN sdkmanager "system-images;android-30;google_apis;arm64-v8a"
RUN echo "no" | avdmanager create avd -n Nexus_4_API_30 -k "system-images;android-30;google_apis;arm64-v8a"
RUN emulator -avd Nexus_4_API_30 -no-window -no-audio -no-boot-anim &

FROM cirrusci/flutter:stable
RUN apt-get update
RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev lcov
COPY ./src ./docker_flutter
WORKDIR /docker_flutter
RUN flutter test --coverage
RUN lcov --capture --directory ./coverage --output-file lcov.info
