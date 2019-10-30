class ExternalApi::V1::ViewerController < ExternalApiController
  before_action :authenticate_admin!

  def teams
    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    scores = Score.all.order(runner_started_at: :desc)
    score_map = {}

    teams.each do |team|
      score_map[team.id] = {}
      rounds.each do |round|
        problems.each do |problem|
          # get score from team login name, exploit container name which is before than round started
          score = find_score(scores, team.login_name, problem.exploit_container_name, round.start_at)
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
    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    scores = Score.all.order(runner_started_at: :desc)

    result = []
    problem_map = {}

    teams.each do |team|
      score_map = {}
      problems.each do |problem|
        score_map[problem.id] = {}
        rounds.each do |round|
          # get score from team login name, exploit container name which is before than round started
          score = find_score(scores, team.login_name, problem.exploit_container_name, round.start_at)
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

    teams = Team.where(account_type: :real)
    problems = Problem.where(hidden: [false, nil])
    rounds = Round.where(disabled: [false, nil])
    scores = Score.all.order(runner_started_at: :desc)

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
          # get score from team login name, exploit container name which is before than round started
          score = find_score(scores, team.login_name, problem.exploit_container_name, round.start_at)
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
        round_start_at: round&.start_at,
        ntrials: problem.ntrials,
        succeeded: score.succeeded,
        x11_required: problem.x11_required,
        score: calclated_score
      }
    }
  end

  def capture_id
    round_captures = RunnerMaster::get_round_capture(params[:id])
    capture_ids = round_captures[params[:type]] || []
    render json: {
      id: capture_ids.sample
    }
  end

  def capture_type
    round_captures = RunnerMaster::get_round_capture(params[:id])
    types = []
    round_captures.each do |type, values|
      next if not values.length > 0
      types.push(type)
    end
    render json: {
      types: types
    }
  end

  # get a sore which has same image_digest, team_login_name and problem_name before before_at
  # scores are sorted by runner_started_at so that it returns latest score
  def find_score(scores, team_login_name, exploit_container_name, before_at)
    scores.find { |score|
      (score.team_login_name == team_login_name &&
        score.problem_name == exploit_container_name && score.runner_started_at.to_i <= before_at.to_i)
    }
  end
end
