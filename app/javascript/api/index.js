import axios from 'axios'

export function login({name, password}) {
  return axios.post('/external_api/v1/login', {
    name,
    password
  })
}

export function fetchProblems() {
  return axios.get('/external_api/v1/problems.json')
}
