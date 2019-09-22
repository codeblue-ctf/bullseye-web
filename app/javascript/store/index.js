import Vue from 'vue'
import Vuex from 'vuex'

import auth from './modules/auth'
import problem from './modules/problem'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth,
    problem
  }
})