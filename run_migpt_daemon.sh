#!/bin/bash
# MiGPT 自动保活守护脚本
HERMES_DIR="/Users/tsingyoung1/Documents/hermes"
LOG_FILE="/Users/tsingyoung1/.hermes/logs/migpt.log"

cd "$HERMES_DIR/migpt-next/apps/example" || exit 1

echo "[MiGPT Daemon] 启动保活循环..." >> "$LOG_FILE"

while true; do
    echo "[MiGPT Daemon] 正在启动 node app.js ($(date))" >> "$LOG_FILE"
    node app.js >> "$LOG_FILE" 2>&1
    EXIT_CODE=$?
    echo "[MiGPT Daemon] app.js 退出 (退出码: $EXIT_CODE), 5秒后自动重启..." >> "$LOG_FILE"
    sleep 5
done
