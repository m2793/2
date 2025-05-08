import { createRouter, createWebHistory } from 'vue-router'
import GestureView from '../views/GestureView.vue'

const routes = [
  {
    path: '/',
    name: 'GestureView',
    component: GestureView
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  console.log('Navigating to:', to.name)
  next()
})

export default router