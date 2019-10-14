import router from 'router'
import * as api from '../../api'

const tokenKeyName = 'bullseye-token'

const initialToken = JSON.parse(window.localStorage.getItem(tokenKeyName)) || null
const state = {
  currentTeam: {},
  signedIn: !!initialToken,
  tokens: initialToken || {}
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
  },
  async fetchCurrentTeam ({ commit, state }) {
    const res = await api.fetchCurrentTeam()
    commit('setTeam', res.data)
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

    // store token to localStorage
    window.localStorage.setItem(tokenKeyName, JSON.stringify(state.tokens))
  },
  logout (state) {
    state.signedIn = false
    state.tokens = {}

    // remove token from localStorage
    window.localStorage.removeItem(tokenKeyName)
  },
  setTeam (state, { current_team }) {
    state.currentTeam = current_team
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
