import Vue from 'vue'
import Router from 'vue-router'
import Home from './components/Home.vue'
import Problems from './components/Problems.vue'
import Problem from './components/Problem.vue'
import Signin from './components/Signin.vue'

Vue.use(Router)

export default new Router({
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
      path: '/problems',
      name: 'problems',
      component: Problems
    },
    {
      path: '/problems/:id',
      name: 'problem',
      component: Problem,
      props: (route) => ( { id: parseInt(route.params.id) } )
    }
  ]
})
