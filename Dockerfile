FROM androidsdk/android-30
RUN echo "no" | avdmanager create avd -n testEmulator -k "system-images;android-30;google_apis;x86_64"
RUN emulator -avd testEmulator -no-window -no-audio -no-boot-anim &

FROM cirrusci/flutter:dev
RUN apt-get update
RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev lcov
COPY ./src ./docker_flutter
WORKDIR /docker_flutter
RUN flutter test --coverage
RUN lcov --capture --directory ./coverage --output-file lcov.info
