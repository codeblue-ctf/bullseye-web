import router from 'router'
import * as api from '../../api'

const state = {
  signedIn: false,
  token: ''
}

const actions = {
  login ({ commit, state }, data) {
    api.login(data).then(res => commit('login', res.data)).catch(err => err)
  },
  logout ({ commit, state }) {
    router.push('/signin')
  }
}

const mutations = {
  login (state, { token }) {
    state.signedIn = true
    state.token = token
  },

  logout (state) {
    state.signedIn = false
    state.token = ''
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
