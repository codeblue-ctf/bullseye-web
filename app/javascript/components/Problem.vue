<template>
  <div v-if="problem && currentTeam">
    <h1 class="display-4 mb-4">{{problem.title}}</h1>

    <pre>{{problem.statement}}</pre>

    <div class="card mb-4">
      <div class="card-header">docker_compose.yml:</div>
      <pre class="card-body"><code>{{problem.docker_compose}}</code></pre>
    </div>

    <p>Submit your exploit:</p>
    <pre class="border bg-light p-2"><code>$ docker login {{config.docker_registry_host}}
> Username: {{ currentTeam.login_name }}
> Password: YOUR_TEAM_PASSWORD
$ docker build -t {{config.docker_registry_host}}/{{ currentTeam.login_name }}/{{problem.exploit_container_name}} DIRECTORY_OF_YOUR_EXPLOIT_DOCKERFILE
$ docker push {{config.docker_registry_host}}/{{ currentTeam.login_name }}/{{problem.exploit_container_name}}</code></pre>

    <p>Test your exploit in local:</p>
    <pre class="border bg-light p-2"><code>$ cat docker-compose.yml # It is the docker-compose.yml of this problem
version '2'
...
$ echo -n "CBCTF{TEST_FLAG}" > ./flag
$ echo -n "" > ./submit_flag
$ docker-compose up -d
$ cat submit_flag # CBCTF{TEST_FLAG} will be shown if your exploit succeeded
$ docker-compose down</code></pre>

    <dl class="row">
      <dt class="col-sm-3">Flag Format</dt>
      <dd class="col-sm-9">{{problem.flat_format}}</dd>

      <dt class="col-sm-3">Number of trials</dt>
      <dd class="col-sm-9">{{problem.ntrials}}</dd>

      <dt class="col-sm-3">Calculation of score</dt>
      <dd class="col-sm-9">{{problem.calc_formula}}</dd>

      <dt class="col-sm-3">Timeout (millisec)</dt>
      <dd class="col-sm-9">{{problem.timeout}}</dd>
    </dl>

    <div>
      <h2>Your exploits</h2>

      <table class="table">
        <thead>
          <tr>
            <th scope="col">score (succeeded/total)</th>
            <th scope="col">image digest</th>
            <th scope="col">runner started at</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="score in scores">
            <td>{{score.calclated_score}} ({{score.succeeded}}/{{score.executed}})</td>
            <td>{{score.image_digest}}</td>
            <td>{{score.runner_started_at}}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  props: ['id'],
  computed: {
    ...mapState('auth', {
      currentTeam(state) {
        return state.currentTeam
      }
    }),
    ...mapState(['config', 'auth']),
    ...mapState('problem', {
      detail(state) {
        return state.problemDetails[this.id]
      },
      problem() {
        return this.detail && this.detail.problem
      },
      scores() {
        return this.detail && this.detail.scores
      }
    })
  },
  created () {
    this.$store.dispatch('problem/fetch', { id: this.id })
  }
}
</script>
