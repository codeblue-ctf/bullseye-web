import router from 'router'
import * as api from '../../api'

const state = {
  signedIn: false,
  token: null
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
    state.token = res.headers['access-token']
  },

  logout (state) {
    state.signedIn = false
    state.token = null
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
