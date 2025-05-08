<template>
  <div class="gesture-container">
    <!-- 操作说明 -->
    <div class="instructions">
      <h2>{{ $t('instructionsTitle') }}</h2>
      <p>{{ $t('instructionsContent') }}</p>
    </div>
    <!-- 按钮组 -->
    <div class="button-group">
      <el-button @click="startGestureRecognition">{{ $t('startGesture') }}</el-button>
      <el-button @click="stopGestureRecognition">{{ $t('stopGesture') }}</el-button>
    </div>
    <p :class="getGestureStatusClass()">{{ $t('gestureStatus', { status: gestureStatus }) }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useGestureStore } from '../stores'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()
const gestureStore = useGestureStore()
const gestureStatus = ref(gestureStore.gestureStatus)

// 开始手势识别
const startGestureRecognition = async () => {
  try {
    console.log('Sending request to backend...')
    const response = await fetch('http://localhost:5000/start_gesture_recognition')
    console.log('Response status:', response.status)
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    const data = await response.json()
    console.log('Received data from backend:', data)
    gestureStore.updateGestureStatus(data.message)
    gestureStatus.value = gestureStore.gestureStatus
  } catch (error) {
    console.error('Error starting gesture recognition:', error)
  }
}

// 停止手势识别
const stopGestureRecognition = async () => {
  try {
    console.log('Sending request to backend to stop...')
    const response = await fetch('http://localhost:5000/stop_gesture_recognition')
    console.log('Response status:', response.status)
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    const data = await response.json()
    console.log('Received data from backend:', data)
    gestureStore.updateGestureStatus(data.message)
    gestureStatus.value = gestureStore.gestureStatus
  } catch (error) {
    console.error('Error stopping gesture recognition:', error)
  }
}

const getGestureStatusClass = () => {
  if (gestureStatus.value === '识别中') {
    return 'status-active';
  } else if (gestureStatus.value === '已停止') {
    return 'status-inactive';
  }
  return '';
}
</script>

<style scoped>
/* 整体容器样式 */
.gesture-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  background-color: #f4f7fa; /* 整体背景颜色 */
  background-image: linear-gradient(to bottom, #a6e3ff, #ffffff);
  padding: 20px;
}

/* 操作说明框样式 */
.instructions {
  width: 80%;
  max-width: 600px;
  background-color: #ffffff; /* 白色背景 */
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 柔和阴影 */
  padding: 20px;
  margin-bottom: 30px;
  text-align: center;
  animation: fadeIn 1s ease;
  transition: transform 0.3s ease; /* 增加过渡效果 */
}

.instructions:hover {
  transform: scale(1.02); /* 悬停时放大 */
}

.instructions h2 {
  color: #333;
  font-size: 24px;
  margin-bottom: 10px;
}

.instructions p {
  color: #666;
  font-size: 16px;
}

/* 按钮组样式 */
.button-group {
  display: flex;
  gap: 20px;
  margin-bottom: 30px;
}

/* 按钮样式 */
.el-button {
  padding: 48px 96px;
  font-size: 32px;
  border-radius: 8px;
  background-color: #2196f3; /* 蓝色背景 */
  border: none;
  color: #fff;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: relative;
  overflow: hidden;
}

.el-button::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  transform: translate(-50%, -50%);
  transition: width 0.3s ease, height 0.3s ease;
}

.el-button:hover {
  background-color: #1976d2; /* 悬停时颜色加深 */
  transform: translateY(-2px); /* 向上移动 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.el-button:hover::before {
  width: 200%;
  height: 200%;
}

.el-button:active {
  transform: translateY(0);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 手势状态提示样式 */
.status-active {
  color: #4caf50; /* 绿色表示识别中 */
  font-weight: bold;
  font-size: 18px;
  animation: pulse 1.5s infinite; /* 增加脉冲动画 */
}

.status-inactive {
  color: #9e9e9e; /* 灰色表示已停止 */
  font-size: 18px;
  transition: color 0.3s ease; /* 增加颜色过渡效果 */
}

/* 淡入动画 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}


/* 脉冲动画 */
@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}

/* 响应式设计 */
@media (max-width: 600px) {
  .instructions {
    width: 90%;
  }

  .button-group {
    flex-direction: column;
    width: 90%;
  }

  .el-button {
    width: 100%;
  }
}
</style>