class InternalApi::V1::ImageController < InternalApiController
  def register
    params[:events].each { |event|
      # only accept push event
      if event[:action] != 'push' then
        next
      end

      team_name = event[:actor][:name]
      exploit_name = event[:target][:repository].match(/^[^\/]+\/([^\/]+)$/)[1]

      team = Team.find(login_name: team_name)
      problem = Problem.find(exploit_container_name: exploit_name)
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
