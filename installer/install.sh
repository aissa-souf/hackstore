
#!/usr/bin/env bash

# ============================================================
# HackStore VPS Manager Installer
# Version : 1.0.0
# Author  : HackStore
# ============================================================

set -e

clear

echo "========================================="
echo "      HackStore VPS Manager Installer"
echo "========================================="
echo ""

# Check root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this installer as root."
    exit 1
fi

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
else
    echo "Unsupported operating system."
    exit 1
fi

echo "Detected OS : $OS"
echo "Version     : $VERSION"
echo ""

echo "Updating packages..."

case "$OS" in
    ubuntu|debian)
        apt update -y
        apt upgrade -y
        apt install -y curl wget git unzip sudo python3 python3-pip sqlite3 cron
        ;;
    rocky|almalinux|centos|fedora)
        dnf update -y
        dnf install -y curl wget git unzip sudo python3 python3-pip sqlite cronie
        ;;
    *)
        echo "Unsupported OS : $OS"
        exit 1
        ;;
esac

echo ""
echo "Packages installed successfully."
echo ""

mkdir -p /opt/hackstore
mkdir -p /opt/hackstore/logs
mkdir -p /opt/hackstore/backups

echo "Directories created."

echo ""
echo "Installation stage 1 completed."
echo "Next: detect_os.sh"
