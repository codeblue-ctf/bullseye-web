import Vue from 'vue'
import App from '../app.vue'
import router from '../router'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount('#app')
})
