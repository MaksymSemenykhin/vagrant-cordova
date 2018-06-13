#!/usr/bin/env bash
source /image/provision/output.sh
source /image/provision/functions.sh

/opt/android-sdk/platform-tools/adb start-server

print_title "Done | always-as-root"
