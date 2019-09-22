import * as api from '../../api'
import Vue from 'vue'

const state = {
  problems: [],
  problemDetails: {}
}

const actions = {
  fetch ({ commit, state }, { id }) {
    api.fetchProblem(id).then(res => commit('fetchProblemDetail', {
      id,
      data: res.data
    })).catch(err => err)
  },
  fetchAll ({ commit, state }, data) {
    api.fetchProblems().then(res => commit('fetchProblems', res.data)).catch(err => err)
  }
}

const mutations = {
  fetchProblemDetail (state, { id, data }) {
    state.problemDetails = { ... state.problemDetails,
      [id]: data
    }
  },
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
