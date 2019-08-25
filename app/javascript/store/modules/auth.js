import router from 'router'
import * as api from '../../api'

const state = {
  signedIn: false,
  tokens: {}
}

const actions = {
  async login ({ commit, state }, data) {
    const res = await api.login(data)
    commit('login', res)

    // validate fetched token
    const validResult = await api.validateToken()
    if (validResult) {
      router.push({ name: 'home' })
    } else {
      commit('logout')
      router.push({ name: 'signin' })
    }
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
