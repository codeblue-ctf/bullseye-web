import Vue from 'vue'
import App from '../viewer/app.vue'
import router from '../viewer/router'
import store from '../viewer/store'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount('#app')
})
