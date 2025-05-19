# stress-test-script
Auto CPU stress test with temperature logging
# Auto CPU Stress Test with Logging

This script automatically detects your CPU model and logical core count, performs a stress test using the appropriate number of threads, and logs CPU temperature and usage during the test.

> ✅ Useful for hardware diagnostics, server stability checks, and thermal performance validation.

---

## 🧪 What It Does

- Detects CPU model and core count
- Stresses all CPU cores for a defined duration
- Logs real-time temperature, CPU usage, and load average
- Saves logs to a timestamped file for later analysis

---

## ⚙️ Requirements

Install required tools before running:

```bash
sudo apt update
sudo apt install -y stress lm-sensors
sudo sensors-detect --auto

