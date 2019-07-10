import axios from 'axios'

export function login({name, password}) {
  return axios.post('/api/login', {
    name,
    password
  })
}

export function fetchProblems() {
  return axios.post('/api/problems')
}
