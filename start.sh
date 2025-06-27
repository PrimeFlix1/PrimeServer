#!/bin/bash

# Set timezone
export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Install dependencies (if not already present)
apt-get update
apt-get install -y tmate expect python3

# Start a simple HTTP server in background (this opens port 8000)
python3 -m http.server 8000 --bind 0.0.0.0 &
echo "📡 Dummy web server started on port 8000..."

# Start tmate in background
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# Show tmate access info
echo "🔐 SSH access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
echo "🌐 Web access (read-write):"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

# Keep container alive and active
while true; do
    tmate -S /tmp/tmate.sock send-keys "echo alive && date" C-m
    sleep 300
done
