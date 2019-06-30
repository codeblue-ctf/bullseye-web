<template>
  <div>
    <h2>Sign In</h2>
    
    <form v-on:submit.prevent="login">
      <div>
        <label>Login name</label>
        <input type="text" v-model="name">
      </div>
    
      <div>
        <label>Password</label>
        <input type="password" v-model="password">
      </div>

      <div>
        <input type="submit">
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      name: '',
      password: '',
    }
  },
  methods: {
    login () {
      this.$store.dispatch('auth/login', {
        name: this.name,
        password: this.password
      })
    }
  }
}
</script>
