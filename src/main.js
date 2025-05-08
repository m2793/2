import { createApp } from 'vue'
import App from './App.vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import { createPinia } from 'pinia'
import router from './router'
import { createI18n } from 'vue-i18n'
import messages from './i18n'

const i18n = createI18n({
  legacy: false, 
  locale: 'zh', // 设置为中文
  messages
})

const pinia = createPinia()
const app = createApp(App)

app.use(ElementPlus)
app.use(pinia)
app.use(router)
app.use(i18n)

app.mount('#app')