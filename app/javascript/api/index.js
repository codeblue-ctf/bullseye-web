export function login({name, password}) {
  console.log(name, password)
  return new Promise((res, rej) => {
    res(1)
  })
}