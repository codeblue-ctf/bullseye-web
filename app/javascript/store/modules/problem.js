import * as api from '../../api'

const state = {
  problems: []
}

const actions = {
  fetch ({ commit, state }, data) {
    api.fetchProblems().then(res => commit('fetchProblems', res.data)).catch(err => err)
  }
}

const mutations = {
  fetchProblems (state, { problems }) {
    state.problems = problems
  }
}

export default {
  namespaced: true,
  state,
  actions,
  mutations
}
