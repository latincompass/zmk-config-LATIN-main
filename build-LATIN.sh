#!/bin/bash

# Building Totem for Xiao BLE

set -e # stop on error

# Paths
PROJECT_DIR="$HOME/Documents/zmk-config-LATIN"
DOWNLOADS_DIR="$HOME/Downloads"
ZEPHYR_SDK="$HOME/.opt/zephyr-sdk-0.17.4"

# File Names
FIRMWARE="LATIN-seeeduino_xiao_ble-zmk_local-build.uf2"


echo "=== Building LATIN Firmware ==="

cd "$PROJECT_DIR"

# Old builds cleanup
echo "Old builds cleanup..."
rm -rf build-LATIN

# Environment setup
export ZEPHYR_BASE="$PWD/zephyr"
export ZEPHYR_SDK_INSTALL_DIR="$ZEPHYR_SDK"
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr

# Registering Zephyr in CMake
echo "Registering Zephyr..."
west zephyr-export

# Left half built
echo ""
echo ">>> Building left half..."
west build -p -b seeeduino_xiao_ble -d build-LATIN -s zmk/app -- -DSHIELD=LATIN -DZMK_CONFIG="$PWD/config"



# Copy artefacts into Downloads folder
echo ""
echo ">>> Copying files into Downloads folder..."

cp "build-LATIN/zephyr/zmk.uf2" "$DOWNLOADS_DIR/$LATIN_FIRMWARE"
echo "✓ Left: $DOWNLOADS_DIR/$LATIN_FIRMWARE"



echo ""
echo "=== Done! ==="
echo "Firmware saved into $DOWNLOADS_DIR"
