const state = {}
window.addEventListener('DOMContentLoaded', () => {
  const dataElem = document.getElementById('initial-data')
  if (!dataElem) {
    return
  }
  const data = dataElem.getAttribute('data-config')
  if (!data) {
    return
  }
  Object.assign(state, JSON.parse(data))
})

const actions = {
}

const mutations = {
}

export default {
  state,
  actions,
  mutations
}
