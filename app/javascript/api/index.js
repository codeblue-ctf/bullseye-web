import axios from 'axios'



export function login({name, password}) {
  console.log(name, password)
  return axios.post('/api/login', {
    name,
    password
  });
}