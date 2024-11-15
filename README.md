# 评论生成器

一个基于阿里云服务的评论生成系统，支持多种社交平台风格的评论生成。

## 功能特点

- 支持多种评论风格（B站、小红书、抖音）
- 简洁的用户界面
- 实时评论生成

## 环境要求

- Node.js v14 或更高版本
- npm v6 或更高版本

## 快速开始

1. 克隆项目后，修改 `run.sh` 中的环境变量：
```bash
export ALIBABA_CLOUD_ACCESS_KEY_ID="your_access_key_id"
export ALIBABA_CLOUD_ACCESS_KEY_SECRET="your_access_key_secret"
```

2. 给运行脚本添加执行权限：
```bash
chmod +x run.sh
```

3. 运行项目：
```bash
./run.sh
```

## 访问地址

- 前端界面：http://localhost:5173
- 后端API：http://localhost:3000

## API 接口

### 生成评论

- 接口：`POST /generate-comments`
- 请求体示例：
```json
{
  "content": "要生成评论的内容",
  "style": "bilibili"  // 可选值：bilibili, xiaohongshu, douyin
}
```

## 项目结构

```
.
├── src/
│   ├── client.js          # 阿里云API客户端
│   ├── server.js          # Express后端服务
│   └── components/        # Vue组件
│       └── CommentGenerator.vue
├── package.json
├── run.sh                 # 启动脚本
└── README.md
```

## 注意事项

1. 确保在运行前已正确设置阿里云的 AccessKey ID 和 Secret
2. 默认后端服务运行在 3000 端口，前端开发服务器运行在 5173 端口
3. 生产环境部署时建议使用 PM2 等进程管理工具

## 技术栈

- 前端：Vue 3 + Vite
- 后端：Express.js
- API：阿里云全妙轻应用服务