<template>
  <div>
    <h1 class="display-4 mb-4">Sign In</h1>
    
    <form v-on:submit.prevent="login">
      <div class="form-group">
        <label>Login name</label>
        <input class="form-control" type="text" v-model="name">
      </div>
    
      <div class="form-group">
        <label>Password</label>
        <input class="form-control" type="password" v-model="password">
      </div>

      <div class="form-group">
        <input type="submit" class="btn btn-primary">
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
    async login () {
      await this.$store.dispatch('auth/login', {
        name: this.name,
        password: this.password
      })
      await this.$store.dispatch('auth/fetchCurrentTeam')
    }
  }
}
</script>
