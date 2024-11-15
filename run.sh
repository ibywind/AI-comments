#!/bin/bash

# 设置环境变量
export ALIBABA_CLOUD_ACCESS_KEY_ID="..."
export ALIBABA_CLOUD_ACCESS_KEY_SECRET="..."

# 检查 node 和 npm 是否安装
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Please install Node.js first."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install npm first."
    exit 1
fi

# 安装依赖
echo "Installing dependencies..."
npm install

# 构建前端项目
echo "Building frontend..."
npm run build

# 创建日志目录
mkdir -p logs

# 启动后端服务
echo "Starting backend server..."
node src/server.js > logs/backend.log 2>&1 &
BACKEND_PID=$!

# 等待后端服务启动
sleep 2

# 启动前端开发服务器
echo "Starting frontend server..."
npm run preview > logs/frontend.log 2>&1 &
FRONTEND_PID=$!

echo "Services started successfully!"
echo "Frontend is available at: http://localhost:4173"
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

# 等待所有后台进程
wait