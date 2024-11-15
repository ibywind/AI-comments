<template>
  <div class="comment-generator">
    <form @submit.prevent="submitForm">
      <div class="form-container">
        <div class="form-group">
          <label for="content">文案：</label>
          <textarea
            id="content"
            v-model="formData.content"
            rows="4"
            class="form-control"
            required
            placeholder="请输入要生成评论的文案内容"
          ></textarea>
        </div>

        <div class="form-group style-select">
          <label for="style">评论风格：</label>
          <select
            id="style"
            v-model="formData.style"
            class="form-control select-control"
            required
          >
            <option value="bilibili">B站</option>
            <option value="xiaohongshu">小红书</option>
            <option value="douyin">抖音</option>
          </select>
        </div>

        <div class="button-container">
          <button type="submit" class="submit-btn" :disabled="loading">
            {{ loading ? '生成中...' : '生成评论' }}
          </button>
        </div>
      </div>
    </form>

    <div class="result-section" v-if="commentList.length">
      <h3>生成的评论：</h3>
      <div class="comments-list">
        <div v-for="(comment, index) in commentList" 
             :key="index" 
             class="comment-item"
        >
          {{ comment }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

const formData = reactive({
  content: '',
  style: 'bilibili'
})

const commentList = ref([])
const loading = ref(false)

const submitForm = async () => {
  loading.value = true
  try {
    const response = await fetch('http://localhost:3000/generate-comments', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(formData)
    })
    const data = await response.json()
    commentList.value = Array.isArray(data.comments) ? 
      data.comments : 
      data.comments.split('\n').filter(comment => comment.trim())
  } catch (error) {
    console.error('Error:', error)
    alert('生成评论失败，请重试')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.comment-generator {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.form-container {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

/* 风格选择器的特殊样式 */
.style-select {
  width: fit-content;
  min-width: 200px;
}

.form-group label {
  font-weight: bold;
  color: #333;
}

.form-control {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.select-control {
  width: auto;
  min-width: 120px;
  padding: 8px 12px;
}

.form-control:focus {
  outline: none;
  border-color: #4CAF50;
  box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
}

textarea.form-control {
  resize: vertical;
  min-height: 100px;
  width: 100%;
}

select.form-control {
  height: 42px;
  background-color: white;
  cursor: pointer;
}

.button-container {
  width: 100%;
  display: flex;
  justify-content: flex-start;
}

.submit-btn {
  width: 200px;
  background-color: #4CAF50;
  color: white;
  padding: 12px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s;
}

.submit-btn:hover:not(:disabled) {
  background-color: #45a049;
}

.submit-btn:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.result-section {
  margin-top: 30px;
  width: 100%;
}

.result-section h3 {
  margin-bottom: 15px;
  color: #333;
  font-size: 16px;
}

.comments-list {
  width: 100%;
  border: 1px solid #ddd;
  border-radius: 4px;
  padding: 15px;
  max-height: 400px;
  overflow-y: auto;
  background-color: white;
}

.comment-item {
  padding: 12px;
  border-bottom: 1px solid #eee;
  line-height: 1.5;
  transition: background-color 0.2s;
}

.comment-item:last-child {
  border-bottom: none;
}

.comment-item:hover {
  background-color: #f5f5f5;
}

/* 滚动条样式 */
.comments-list::-webkit-scrollbar {
  width: 8px;
}

.comments-list::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.comments-list::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

.comments-list::-webkit-scrollbar-thumb:hover {
  background: #555;
}
</style> 