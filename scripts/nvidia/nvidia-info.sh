echo "COMMAND: nvidia-smi -L"
nvidia-smi -L
echo ===
echo ===
echo ===
echo "COMMAND: nvidia-settings -q NvidiaDriverVersion"
nvidia-settings -q NvidiaDriverVersion
echo ===
echo ===
echo ===
echo "COMMAND: cat /proc/driver/nvidia/version"
cat /proc/driver/nvidia/version
echo ===
echo ===
echo ===
echo "COMMAND: apt-cache search nvidia | grep -P '^nvidia-[0-9]+\s'"
apt-cache search nvidia | grep -P '^nvidia-[0-9]+\s'
echo ===
echo ===
echo ===
