<template>
  <div>
    <header-nav />
    <router-view/>
  </div>
</template>

<script>
import HeaderNav from './components/HeaderNav.vue'
export default {
  components: {
    HeaderNav
  },
  created () {
    this.$store.dispatch('problem/fetch')
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
