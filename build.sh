#!/usr/bin/env bash
# Build script for Dumb NixOS ISO

set -e

echo "==================================="
echo "  Dumb NixOS ISO Builder"
echo "==================================="
echo ""

# Check if nix is installed
if ! command -v nix &> /dev/null; then
    echo "❌ Error: Nix is not installed."
    echo "Please install Nix from https://nixos.org/download.html"
    exit 1
fi

echo "✓ Nix is installed"

# Check if flakes are enabled
if ! nix flake --version &> /dev/null; then
    echo "⚠️  Warning: Flakes might not be enabled."
    echo "Trying to build with flakes anyway..."
fi

echo ""
echo "Starting build process..."
echo "This may take a while (30-60 minutes) on first build."
echo ""

# Build the ISO
nix build .#iso -L

if [ $? -eq 0 ]; then
    echo ""
    echo "==================================="
    echo "✓ Build successful!"
    echo "==================================="
    echo ""
    
    # Find the ISO file
    ISO_PATH=$(find result/iso -name "*.iso" -type f | head -n 1)
    
    if [ -n "$ISO_PATH" ]; then
        ISO_SIZE=$(du -h "$ISO_PATH" | cut -f1)
        ISO_NAME=$(basename "$ISO_PATH")
        
        echo "ISO Information:"
        echo "  Name: $ISO_NAME"
        echo "  Size: $ISO_SIZE"
        echo "  Path: $ISO_PATH"
        echo ""
        echo "SHA256 Checksum:"
        sha256sum "$ISO_PATH"
        echo ""
        echo "You can now write this ISO to a USB drive:"
        echo "  sudo dd if=$ISO_PATH of=/dev/sdX bs=4M status=progress oflag=sync"
        echo ""
    else
        echo "⚠️  Warning: Could not find ISO file in result directory"
    fi
else
    echo ""
    echo "==================================="
    echo "❌ Build failed!"
    echo "==================================="
    echo ""
    echo "Please check the error messages above."
    exit 1
fi
