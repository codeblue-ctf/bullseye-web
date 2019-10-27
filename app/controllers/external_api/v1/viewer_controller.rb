class ExternalApi::V1::ViewerController < ExternalApiController
  before_action :authenticate_admin!

  def teams
    images = RunnerMaster::get_images
    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    image_to_score = Score.all.map { |score| [score.image_digest, score] }.to_h
    score_map = {}

    teams.each do |team|
      score_map[team.id] = {}
      rounds.each do |round|
        problems.each do |problem|
          # search latest image on the current round
          # TODO: this method can be faster
          image = find_image(images, team.login_name, problem.exploit_container_name, round.start_at)
          next if image.nil?
          score = image_to_score[image['digest']]
          next if score.nil?

          # calc score
          calclated_score = score.calc_score(problem.calc_formula)
          next if calclated_score.nil?

          score_map[team.id][score.runner_round_id] = calclated_score
        end
      end
    end

    result = []
    teams.each do |team|
      result.push({
        team_id: team.login_name,
        schedule_team_id: team.id,
        name: team.name,
        score: score_map[team.id] || {}
      })
    end

    render json: result
  end

  def table
    images = RunnerMaster::get_images
    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    image_to_score = Score.all.map { |score| [score.image_digest, score] }.to_h

    result = []
    problem_map = {}

    teams.each do |team|
      score_map = {}
      problems.each do |problem|
        score_map[problem.id] = {}
        rounds.each do |round|
          # search latest image on the current round
          # TODO: this method can be faster
          image = find_image(images, team.login_name, problem.exploit_container_name, round.start_at)
          next if image.nil?
          score = image_to_score[image['digest']]
          next if score.nil?

          # calc score
          calclated_score = score.calc_score(problem.calc_formula)
          next if calclated_score.nil?

          score_map[problem.id][score.runner_round_id] = calclated_score
          problem_map[problem.id] = problem.title
        end
      end

      result.push({
        schedule_team_id: team.id,
        name: team.name,
        score: score_map
      })
    end

    render json: {team: result, problem: problem_map}
  end

  def problems
    result = {}

    images = RunnerMaster::get_images
    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    image_to_score = Score.all.map { |score| [score.image_digest, score] }.to_h

    problems.each do |problem|
      result[problem.id] = {
        name: problem.title,
        round: {}
      }
      rounds.each do |round|
        result[problem.id][:round][round.id] = {}
        result[problem.id][:round][round.id][:start_at] = round.start_at
        result[problem.id][:round][round.id][:team_result] = {}
        teams.each do |team|
          # search latest image on the current round
          # TODO: this method can be faster
          image = find_image(images, team.login_name, problem.exploit_container_name, round.start_at)
          next if image.nil?
          score = image_to_score[image['digest']]
          next if score.nil?

          result[problem.id][:round][round.id][:team_result][team.id] = score.runner_round_id
        end
      end
    end

    render json: result
  end

  def score
    score = Score.find_by(runner_round_id: params[:id])
    problem = Problem.find_by(exploit_container_name: score.problem_name)
    team = Team.find_by(login_name: score.team_login_name)
    # XXX: 正確なroundはわからないのでrunner_started_atから推測する
    # XXX: runner_started_at は UTCなのでJSTに変える
    runner_started_at_in_tokyo = Time.parse(score.runner_started_at.to_s + ' +00:00').in_time_zone('Tokyo')
    round = Round.where('start_at <= ?', runner_started_at_in_tokyo).order(start_at: 'DESC').first
    calclated_score = score.calc_score(problem.calc_formula)
    render json: {
      team: {
        team_id: team.login_name,
        name: team.name
      },
      problem: {
        problem_id: problem.id,
        name: problem.title,
        round_id: round&.id,
        ntrials: problem.ntrials,
        succeeded: score.succeeded,
        score: calclated_score
      }
    }
  end

  private
  def find_image(images, team, problem, before_at)
    # XXX: image['CreatedAt'] はUTCなのでJSTに変えておく
    images = images.map{ |i|
      new_i = i.dup
      new_i['CreatedAt'] = Time.parse(new_i['CreatedAt'] + ' +00:00').in_time_zone('Tokyo')
      new_i
    }
    images
      .sort { |a, b| b['CreatedAt'] <=> a['CreatedAt'] } # find latest image
      .find { |image|
        (image['team'] == team && image['problem'] == problem &&
          image['CreatedAt'].to_i <= before_at.to_i)
      }
  end
end
