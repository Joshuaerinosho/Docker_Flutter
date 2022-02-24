FROM androidsdk/android-30 AS build
RUN android_emulator.sh


FROM cirrusci/flutter:dev
COPY --from=build . ./bin/emulator
RUN apt-get update
RUN apt-get install -y --no-install-recommends cmake ninja-build clang build-essential pkg-config libgtk-3-dev liblzma-dev lcov
COPY . ./docker_flutter
WORKDIR /docker_flutter
RUN flutter test --coverage
RUN lcov --capture --directory ./coverage --output-file lcov.info