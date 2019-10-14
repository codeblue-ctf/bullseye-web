import store from 'store'
import axios from 'axios'

const http = () => {
  // get CSRF token
  // TODO: get token from state
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const newAxios = axios.create({
    withCredentials: true,
    headers: {
      'X-CSRF-Token': csrfToken,
      'access-token': store.state.auth.tokens['access-token'],
      'client': store.state.auth.tokens['client'],
      'uid': store.state.auth.tokens['uid'],
      'token-type': store.state.auth.tokens['token-type'],
      'expiry': store.state.auth.tokens['expiry']
    }
  })
  newAxios.interceptors.response.use(res => res, (error) => {
    if (error.response.status === 401) {
      store.dispatch('auth/logout')
    }
    return Promise.reject(error)
  })

  return newAxios
}

export function login({name, password}) {
  return http().post('/external_api/v1/auth/sign_in', {
    login_name: name,
    password
  })
}

export function validateToken() {
  return http().get('/external_api/v1/auth/validate_token')
}

export function fetchProblems() {
  return http().get('/external_api/v1/problems.json')
}

export function fetchProblem(id) {
  return http().get(`/external_api/v1/problems/${id}.json`)
}

export function fetchCurrentTeam() {
  return http().get(`/external_api/v1/current_team.json`)
}
