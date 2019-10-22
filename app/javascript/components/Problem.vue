<template>
  <div v-if="problem && currentTeam">
    <p>{{problem.title}}</p>

    <p>{{problem.statement}}</p>

    <div>
      <strong>docker_compose.yml:</strong>
      <pre>{{problem.docker_compose}}</pre>
    </div>

    <p>Following commands are the example to submit your exploit</p>
    <pre>
$ docker login {{config.docker_registry_host}}
> Username: {{ currentTeam.login_name }}
> Password: YOUR_TEAM_PASSWORD
$ docker build -t {{config.docker_registry_host}}/{{ currentTeam.login_name }}/{{problem.exploit_container_name}} DIRECTORY_OF_YOUR_EXPLOIT_DOCKERFILE
$ docker push {{config.docker_registry_host}}/{{ currentTeam.login_name }}/{{problem.exploit_container_name}}
    </pre>

    <p>How to test your exploit</p>
    <pre>
$ cat docker-compose.yml # It should be docker-compose.yml of this problem
version '2'
...
$ echo "CBCTF{TEST_FLAG}" > ./flag
$ echo "" > ./submit_flag
$ docker-compose up -d
$ cat submitted-flag # CBCTF{TEST_FLAG} will be shown if your exploit succeeded
$ docker-compose down
    </pre>

    <p>
      <strong>Number of trials:</strong>
      <pre>{{problem.ntrials}}</pre>
    </p>

    <p>
      <strong>Calculation of score:</strong>
      <pre>{{problem.calc_formula}}</pre>
    </p>

    <p>
      <strong>Timeout (millsec):</strong>
      <pre>{{problem.timeout}}</pre>
    </p>


    <div>
      <h2>Submitted exploits</h2>

      <table>
        <thead>
          <tr>
            <th>image tag</th>
            <th>image digest</th>
            <th>uploaded at</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="image in images">
            <td>{{image.tag}}</td>
            <td>{{image.image_digest}}</td>
            <td>{{image.uploaded_at}}</td>
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
      images() {
        return this.detail && this.detail.images
      }
    })
  },
  created () {
    this.$store.dispatch('problem/fetch', { id: this.id })
  }
}
</script>
