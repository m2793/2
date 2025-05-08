import { defineStore } from 'pinia'

export const useGestureStore = defineStore('gesture', {
  state: () => ({
    gestureStatus: 'Idle'
  }),
  actions: {
    updateGestureStatus(status) {
      this.gestureStatus = status
    }
  }
})