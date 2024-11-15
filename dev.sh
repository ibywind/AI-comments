#!/bin/bash

# 设置环境变量
export ALIBABA_CLOUD_ACCESS_KEY_ID="..."
export ALIBABA_CLOUD_ACCESS_KEY_SECRET="..."

# 创建日志目录
mkdir -p logs

# 启动后端服务（使用nodemon）
echo "Starting backend server in development mode..."
npm run dev:server > logs/backend.log 2>&1 &
BACKEND_PID=$!

# 等待后端服务启动
sleep 2

# 启动前端开发服务器（带热重载）
echo "Starting frontend server in development mode..."
npm run dev > logs/frontend.log 2>&1 &
FRONTEND_PID=$!

echo "Development servers started!"
echo "Frontend is available at: http://localhost:5173"
echo "Backend is available at: http://localhost:3000"
echo "Log files are in the logs directory"
echo "Hot reload is enabled for both frontend and backend"

# 添加清理进程的函数
cleanup() {
    echo "Cleaning up..."
    kill $BACKEND_PID 2>/dev/null
    kill $FRONTEND_PID 2>/dev/null
    exit 0
}

# 注册清理函数
trap cleanup SIGINT SIGTERM

# 显示实时日志
tail -f logs/backend.log logs/frontend.log 