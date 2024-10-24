#!/bin/bash
set -e

./start_all.sh
./novnc_startup.sh

python http_server.py > /tmp/server_logs.txt 2>&1 &

# Add environment variable to disable Streamlit's telemetry prompt
cd /home/hakcer/kali
export STREAMLIT_BROWSER_GATHER_USAGE_STATS=false
export STREAMLIT_SERVER_GATHER_USAGE_STATS=false
STREAMLIT_SERVER_PORT=8501 python -m streamlit run ./hakc_streamlit.py > /dev/null 2>&1 &

echo "✨ k(a)l(i)is ready!"
echo "➡️  Open http://localhost:8080 in your browser to begin"

# Keep the container running
tail -f /dev/null