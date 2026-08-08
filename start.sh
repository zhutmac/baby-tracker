#!/bin/bash

# 小爱音箱接入 HermesAgent 启动脚本

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXAMPLE_DIR="$SCRIPT_DIR/migpt-next/apps/example"
ENV_FILE="$EXAMPLE_DIR/.env"
LOG_DIR="${HOME}/.hermes/logs"
LOG_FILE="$LOG_DIR/migpt.log"

# Keep the bridge output available after the launching terminal is closed.
mkdir -p "$LOG_DIR"
umask 077
if [ -f "$LOG_FILE" ] && [ "$(wc -c < "$LOG_FILE")" -ge 10485760 ]; then
    mv "$LOG_FILE" "$LOG_FILE.1"
fi
exec >>"$LOG_FILE" 2>&1

echo "=========================================="
echo " 🚀 正在启动 小爱音箱 ➔ HermesAgent 桥接服务 "
echo "=========================================="

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ 错误: 未找到配置文件 $ENV_FILE"
    exit 1
fi

# 检查是否修改了默认配置
if grep -q "XIAOMI_USER_ID=1234567" "$ENV_FILE"; then
    echo "⚠️  提醒: 请先编辑配置文件中您的小米账号与音箱信息:"
    echo "👉 配置文件路径: $ENV_FILE"
    echo ""
    echo "修改完成后再重新运行此脚本。"
    exit 1
fi

cd "$EXAMPLE_DIR" || exit 1
echo "✅ 正在连接小米服务与 HermesAgent 端点..."
npm start
