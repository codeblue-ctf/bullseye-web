import Vue from 'vue'
import Router from 'vue-router'
import store from 'store'
import Home from './components/Home.vue'
import Problems from './components/Problems.vue'
import Problem from './components/Problem.vue'
import Signin from './components/Signin.vue'
import Logout from './components/Logout.vue'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/signin',
      name: 'signin',
      component: Signin
    },
    {
      path: '/logout',
      name: 'logout',
      component: Logout
    },
    {
      path: '/problems',
      name: 'problems',
      component: Problems,
      meta: { requiresAuth: true }
    },
    {
      path: '/problems/:id',
      name: 'problem',
      component: Problem,
      props: (route) => ( { id: parseInt(route.params.id) } ),
      meta: { requiresAuth: true }
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth) && !store.state.auth.signedIn) {
    next('signin')
  } else {
    next()
  }
})

export default router