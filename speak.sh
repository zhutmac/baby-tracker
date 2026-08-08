#!/bin/bash
# 方便 Hermes 或任意 Cron 任务主动调用小爱音箱喊话
# 用法: ./speak.sh "需要音箱播报的内容"

TEXT="$1"
if [ -z "$TEXT" ]; then
  echo "用法: ./speak.sh \"需要音箱播报的内容\""
  exit 1
fi

echo "正在触发小爱音箱主动播报: $TEXT"
curl -s -G --data-urlencode "text=$TEXT" "http://127.0.0.1:3999/speak"
echo ""
