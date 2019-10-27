import Vue from 'vue'
import Router from 'vue-router'

// components
import Home from './components/Home.vue'
import Play from './components/Play.vue'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/viewer',
      name: 'home',
      component: Home
    },
    {
      path: '/viewer/play',
      name: 'play',
      component: Play
    },
  ]
})

export default router
