#!/bin/bash

# Auto Stress Test Script with Temperature Logging

# Ensure root access
if [[ $EUID -ne 0 ]]; then
   echo "❌ Please run this script as root (e.g., sudo ./auto_stress_test_with_logging.sh)"
   exit 1
fi

# Setup
echo "🔍 Detecting system info..."
CPUS=$(nproc)
CPU_MODEL=$(lscpu | grep "Model name" | sed 's/Model name:[ \t]*//')
ARCH=$(uname -m)
TOTAL_MEM_MB=$(free -m | awk '/^Mem:/ {print $2}')
USE_MEM_MB=$((TOTAL_MEM_MB * 60 / 100))
VM_WORKERS=2
VM_BYTES_PER="$((USE_MEM_MB / VM_WORKERS))M"
DURATION=300  # in seconds (5 minutes)

# Log file
LOGFILE="cpu_temp_log_$(date +%Y%m%d_%H%M%S).txt"

# Display system info
echo "🧠 CPU: $CPU_MODEL"
echo "🧩 Architecture: $ARCH"
echo "🧮 Threads: $CPUS"
echo "💾 RAM: ${TOTAL_MEM_MB}MB (using $USE_MEM_MB MB for stress test)"
echo "📁 Logging temperatures to $LOGFILE"

# Install required tools
echo "🔧 Installing tools..."
apt update -qq && apt install -y stress-ng lm-sensors htop -qq

# Load sensors (may require this for some systems)
sensors-detect --auto > /dev/null 2>&1

# Initial temp check
echo "🌡️ Initial temperatures:"
sensors || echo "(sensors not supported or no data)"

# Start temp logging in background
echo "📊 Logging temperatures every 10 seconds for $DURATION seconds..."
(
    echo "Timestamp | Temperature Output" >> "$LOGFILE"
    for ((i = 0; i < DURATION; i += 10)); do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')]" >> "$LOGFILE"
        sensors >> "$LOGFILE" 2>/dev/null
        echo "----------------------------------------" >> "$LOGFILE"
        sleep 10
    done
) &

LOGGER_PID=$!

# Run stress test
echo "⚙️ Starting stress-ng test..."
stress-ng --cpu "$CPUS" --vm "$VM_WORKERS" --vm-bytes "$VM_BYTES_PER" --timeout "${DURATION}s" --metrics-brief

# Wait for logging to finish
wait $LOGGER_PID

# Show results
echo "✅ Stress test finished."
echo "📄 Temperature log saved to: $LOGFILE"
echo "🌡️ Final temperature reading:"
sensors || echo "(sensors not supported or no data)"

echo "📈 Use 'htop' or review 'dmesg' for more info if needed."
exit 0
