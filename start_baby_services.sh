#!/bin/bash
# 一键在 macOS 系统后台独立启动所有童童生活记录相关服务 (含监控告警与自动拉起)

HERMES_DIR="/Users/tsingyoung1/Documents/hermes"
LOG_DIR="/Users/tsingyoung1/.hermes/logs"
PYTHON_BIN="/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.9/Resources/Python.app/Contents/MacOS/Python"

mkdir -p "$LOG_DIR"

echo "=========================================="
echo " 🍼 正在启动 童童生活记录与小爱音箱全套后台服务"
echo "=========================================="

# 1. 启动 MiGPT 保活进程
if ps aux | grep -v grep | grep -q "node app.js"; then
    echo "✅ [1/3] 小爱音箱桥接服务 (MiGPT) 已在运行中"
else
    echo "🚀 [1/3] 正在启动 小爱音箱桥接服务 (MiGPT 自动保活模式)..."
    chmod +x "$HERMES_DIR/run_migpt_daemon.sh"
    nohup "$HERMES_DIR/run_migpt_daemon.sh" > /dev/null 2>&1 &
    sleep 2
fi

# 2. 启动看板 HTTP 服务 & Cloudflare 专属隧道
if ps aux | grep -v grep | grep -q "start_dashboard_cloudflare_server.py"; then
    echo "✅ [2/3] 看板服务 & Cloudflare 域名隧道 已在运行中"
else
    echo "🚀 [2/3] 正在启动 看板服务 & Cloudflare 专属域名隧道..."
    nohup "$PYTHON_BIN" /Users/tsingyoung1/.hermes/scripts/start_dashboard_cloudflare_server.py > "$LOG_DIR/dashboard_server.log" 2>&1 &
    sleep 2
fi

# 3. 启动健康监控与 Telegram 告警守护进程
if ps aux | grep -v grep | grep -q "monitor_baby_services.py"; then
    echo "✅ [3/3] 服务健康监控与 Telegram 告警守护进程 已在运行中"
else
    echo "🚀 [3/3] 正在启动 服务健康监控与 Telegram 告警守护进程..."
    nohup "$PYTHON_BIN" /Users/tsingyoung1/.hermes/scripts/monitor_baby_services.py > "$LOG_DIR/monitor.log" 2>&1 &
    sleep 1
fi

echo "=========================================="
echo "🎉 全部 3 个服务与监控告警守护进程已常驻启动！"
echo "🌐 固定域名访问: https://baby.maxtokens.win"
echo "📱 异常实时告警: 已接入 Hermes Telegram 自动通知"
echo "=========================================="
