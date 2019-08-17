import store from 'store'
import axios from 'axios'

const http = axios.create({ withCredentials: true })
http.interceptors.response.use(res => res, (error) => {
  if (error.response.status === 401) {
    store.dispatch('auth/logout')
  }
  return Promise.reject(error)
})

// get CSRF token
const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
http.defaults.headers.common['X-CSRF-Token'] = csrfToken

export function login({name, password}) {
  return http.post('/external_api/v1/auth/sign_in', {
    login_name: name,
    password
  })
}

export function fetchProblems() {
  return http.get('/external_api/v1/problems.json')
}
