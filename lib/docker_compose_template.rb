module DockerComposeTemplate
  # render following yml template
  # 
  # version: '2'
  # 
  # services:
  #   exploit:
  #     image: registry-y0cf0u1w.finals.ctf.codeblue.jp:5000/%{team}/sample%{exploit_hash}
  #     depends_on:
  #       - problem
  #       - flag-submit
  #   problem:
  #     image: registry-y0cf0u1w.finals.ctf.codeblue.jp:5000/problems/sample
  #     volumes:
  #       - "%{flag_path}:/flag"
  #       - "%{x11_path}}:/tmp/.X11-unix/X0"
  #     expose:
  #       - "8080"
  #     environment:
  #       - TRIAL_NUMBER=%{trial_number}
  #   flag-submit:
  #     image: registry-y0cf0u1w.finals.ctf.codeblue.jp:5000/public/flag-submit
  #     volumes:
  #       - "%{submit_flag_path}:/flag"
  #     expose:
  #       - "8080"
  def self.render(docker_compose, params)
    return nil if docker_compose.nil?

    default_params = {
      team: '',
      exploit_hash: '',
      flag_path: './flag',
      trial_number: '1',
      submit_flag_path: './submit_flag',
      x11_path: '/tmp/.X11-unix/X0',
    }
    params = default_params.merge(params)
    docker_compose % params
  end

  # convert yml to this format
  # 
  # version: '2'
  # 
  # services:
  #   exploit:
  #     image: localhost:5000/{{.team}}/test-challenge{{.exploitHash}}
  #     depends_on:
  #       - challenge
  #       - flag-submit
  #   challenge:
  #     image: localhost:5000/test-challenge
  #     volumes:
  #       - "{{.flagPath}}:/flag"
  #       - "{{.X11Path}}:/tmp/.X11-unix/X0"
  #     expose:
  #       - "8080"
  #     environment:
  #       - TRIAL_NUMBER={{.trialNumber}}
  #   flag-submit:
  #     image: localhost:5000/flag-submit
  #     volumes:
  #       - "{{.submitPath}}:/flag"
  #     expose:
  #       - "1337"
  def self.format_to_runner_template(docker_compose)
    docker_compose % {
      team: '{{.team}}',
      exploit_hash: '{{.exploitHash}}',
      flag_path: '{{.flagPath}}',
      trial_number: '{{.trialNumber}}',
      submit_flag_path: '{{.submitPath}}',
      x11_path: '{{.X11Path}}',
    }
  end
end