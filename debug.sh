#!/bin/bash

# 设置环境变量
export ALIBABA_CLOUD_ACCESS_KEY_ID="..."
export ALIBABA_CLOUD_ACCESS_KEY_SECRET="..."

# 清理已存在的进程
cleanup_existing() {
    echo "Checking for existing processes..."
    # 杀死占用 9229 端口的进程
    lsof -ti:9229 | xargs kill -9 2>/dev/null || true
    # 杀死之前的 node 进程
    pkill -f "node src/server.js" 2>/dev/null || true
    # 等待进程完全终止
    sleep 2
}

# 在启动新进程前清理
cleanup_existing

# 设置 Node.js 调试选项
export NODE_OPTIONS="--inspect-brk=9229"

# 创建日志目录
mkdir -p logs

# 启动后端服务（调试模式）
echo "Starting backend server in debug mode..."
echo "Debug URL: chrome://inspect"
node src/server.js > logs/backend.log 2>&1 &
BACKEND_PID=$!

# 等待后端服务启动
sleep 2

# 启动前端开发服务器（开发模式）
echo "Starting frontend server in development mode..."
npm run dev > logs/frontend.log 2>&1 &
FRONTEND_PID=$!

echo "Services started in debug mode!"
echo "Backend debug port: 9229 (chrome://inspect)"
echo "Frontend is available at: http://localhost:5173"
echo "Backend is available at: http://localhost:3000"
echo "Log files are in the logs directory"

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