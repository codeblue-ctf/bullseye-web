import Vue from 'vue'
import Vuex from 'vuex'
import BootstrapVue from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import auth from './modules/auth'
import config from './modules/config'
import problem from './modules/problem'

Vue.use(Vuex)
Vue.use(BootstrapVue)

export default new Vuex.Store({
  modules: {
    auth,
    config,
    problem
  }
})
