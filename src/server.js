const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const CommentClient = require('./commentClient.js');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

app.post('/generate-comments', async (req, res) => {
  try {
    const { content, style } = req.body;
    
    if (!content || !style) {
      return res.status(400).json({ 
        error: '缺少必要参数',
        details: {
          content: !content ? '内容不能为空' : null,
          style: !style ? '风格不能为空' : null
        }
      });
    }
    
    const styleMap = {
      bilibili: "BILIBILI",
      xiaohongshu: "XIAOHONGSHU",
      douyin: "DOUYIN"
    };

    if (!styleMap[style]) {
      return res.status(400).json({ 
        error: '不支持的评论风格',
        supportedStyles: Object.keys(styleMap)
      });
    }

    console.log('Received request:', { content, style });
    const result = await CommentClient.generateComments(content, styleMap[style]);
    
    if (!result) {
      throw new Error('No result returned from API');
    }

    res.json({ comments: result });
  } catch (error) {
    console.error('Error generating comments:', error);
    
    // 根据错误类型返回不同的状态码和信息
    if (error.code === 'ECONNRESET') {
      res.status(503).json({ 
        error: '服务暂时不可用，请稍后重试',
        retryAfter: 5
      });
    } else {
      res.status(500).json({ 
        error: '生成评论失败',
        message: error.message
      });
    }
  }
});

// 添加错误处理中间件
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  res.status(500).json({ 
    error: '服务器内部错误',
    message: process.env.NODE_ENV === 'development' ? err.message : '请稍后重试'
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
}); 