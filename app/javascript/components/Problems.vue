<template>
  <div>
    <p>problems</p>
  </div>
</template>

<script>
export default {
  data () {
    return {
      problems: []
    }
  },
  mounted () {
    this.$store.dispatch('problem/fetch')
  }
}
</script>
