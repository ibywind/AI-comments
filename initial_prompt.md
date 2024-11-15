我需要一个评论生成系统，具体要求如下：

## 功能需求
1. 前端页面包含：
   - 文案输入框（文本域）
   - 评论风格选择（下拉框，包含：B站、小红书、抖音）
   - 提交按钮
   - 评论结果显示区域（文本域）

2. 后端功能：
   - 接收前端请求
   - 调用阿里云全妙轻应用服务
   - 返回生成的评论结果

3. 技术栈：
   - 前端：Vue 3 + Vite
   - 后端：Node.js + Express
   - API：阿里云全妙轻应用服务

## 项目结构
需要生成以下文件：
1. src/client.js - 阿里云API客户端
2. src/server.js - Express后端服务
3. src/components/CommentGenerator.vue - 前端主组件
4. src/main.js - Vue入口文件
5. index.html - HTML模板
6. vite.config.js - Vite配置
7. package.json - 项目配置
8. run.sh - 启动脚本
9. README.md - 项目说明
10. prompt.md - 评论生成提示词

## 特殊要求
1. 支持一键部署（通过run.sh）
2. 包含日志记录功能
3. 优雅的错误处理
4. 跨域支持
5. 生产环境支持

请帮我生成这个项目的所有相关文件，确保代码完整可运行。每个文件都需要详细的代码实现。 