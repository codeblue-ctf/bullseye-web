class InternalApi::V1::ImageController < InternalApiController
  def register
    # need to parse json because docker registry send with Content-Type: application/vnd.docker.distribution.events.v1+json
    body = request.body.read
    param = JSON.parse(body, {:symbolize_names => true})
    if param[:events].nil?
      render json: { result: 'error' }
    end

    param[:events].each { |event|
      # only accept push event
      if event[:action] != 'push' then
        next
      end

      team_name = event[:actor][:name]
      exploit_name = event[:target][:repository].match(/^[^\/]+\/([^\/]+)$/) do |match|
        match.nil? ? nil : match[1]
      end

      team = Team.where(login_name: team_name).first
      problem = Problem.where(exploit_container_name: exploit_name).first
      if team.nil? or problem.nil? then
        next
      end

      Image.create(
        team_id: team.id,
        problem_id: problem.id,
        image_digest: event[:target][:digest],
        event_log: event.to_json,
        uploaded_at: event[:timestamp]
      )
    }

    render json: { result: 'success' }
  end
end
