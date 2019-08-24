import router from 'router'
import * as api from '../../api'

const state = {
  signedIn: false,
  tokens: {}
}

const actions = {
  login ({ commit, state }, data) {
    api.login(data).then(res => {
      commit('login', res)
      router.push({ name: 'home' })
    }).catch(err => err)
  },
  logout ({ commit, state }) {
    commit('logout')
    router.push({ name: 'signin' })
  }
}

const mutations = {
  login (state, res) {
    state.signedIn = true
    state.tokens = {
      'access-token': res.headers['access-token'],
      'client': res.headers['client'],
      'uid': res.headers['uid'],
      'token-type': res.headers['token-type'],
      'expiry': res.headers['expiry'],
    }
  },

  logout (state) {
    state.signedIn = false
    state.tokens = {}
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
