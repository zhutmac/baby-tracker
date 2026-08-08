#!/bin/bash
# 停止童童生活记录相关的所有后台服务

echo "正在停止后台服务..."
pkill -f "start_dashboard_cloudflare_server.py" 2>/dev/null
pkill -f "cloudflared tunnel run --token" 2>/dev/null
pkill -f "node app.js" 2>/dev/null
sleep 1
echo "✅ 所有后台服务已停止。"
