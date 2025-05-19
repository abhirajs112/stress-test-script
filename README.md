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
🚀 How to Use
bash
Copy
Edit
bash auto_stress_test_with_logging.sh
The script will:

Run a 5-minute stress test

Log system temperature and CPU stats every 10 seconds

Save logs to stress_test_log_YYYYMMDD_HHMMSS.log

📁 Output Example
scss
Copy
Edit
Running stress test on Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz with 8 threads.
Stress test running for 300 seconds (5 minutes)...
[2025-05-19 14:12:01] Temp: 65.0°C | Load Avg: 7.97 | CPU Usage: 98%
[2025-05-19 14:12:11] Temp: 66.5°C | Load Avg: 7.99 | CPU Usage: 99%
...
📌 Notes
Only works on Linux systems (tested on Ubuntu Live OS)

Needs root privileges for sensors detection

You can modify the stress duration by changing the stress --timeout value in the script

🧑‍💻 Author
Abhiraj S
abhirajskumar12@gmail.com
