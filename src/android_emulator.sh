#!/bin/bash

# Arm emulators can be quite slow. For this reason it is convenient
# to increase the adb timeout to avoid errors.
export ADB_INSTALL_TIMEOUT=60

# Download an ARM system image to create an ARM emulator.
sdkmanager "system-images;android-16;default;armeabi-v7a"

# Create an ARM AVD emulator, with a 700 MB SD card storage space. Echo "no"
# because it will ask if you want to use a custom hardware profile, and you don't.
# https://medium.com/@AndreSand/android-emulator-on-docker-container-f20c49b129ef
echo "no" | avdmanager create avd -n Android_4.1_API_16 -k "system-images;android-16;default;armeabi-v7a" -c 700M --force 

# Launch the emulator in the background
$ANDROID_HOME/emulator/emulator -avd Android_4.1_API_16 -no-skin -no-audio -no-window -no-boot-anim -gpu off &
EMULATOR_PID=$!

# Wait for Android to finish booting
WAIT_CMD="$ANDROID_HOME/platform-tools/adb wait-for-device shell getprop init.svc.bootanim"
until $WAIT_CMD | grep -m 1 stopped; do
  echo "Waiting..."
  sleep 1
done

#Run Flutter integration tests on Android emulator
# flutter test integration_test/integration_tests.dart -d emulator-5554

# Kill the emulator
# kill $EMULATOR_PID