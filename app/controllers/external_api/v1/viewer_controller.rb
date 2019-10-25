class ExternalApi::V1::ViewerController < ExternalApiController
  before_action :authenticate_admin!

  def teams
    images = RunnerMaster::get_images
    teams = Team.all
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
    score_map = {}
    problem_map = {}
    schedule_results_all = ScheduleResult.includes(schedule: [:problem])
    schedule_results_all.each do |schedule_result|
      key = schedule_result.schedule.team_id
      score_map[key] ||= {}
      score_map[key][schedule_result.schedule.problem_id] ||= {}
      score_map[key][schedule_result.schedule.problem_id][schedule_result.id] = schedule_result.score
      problem_map[schedule_result.schedule.problem_id] = schedule_result.schedule.problem.title
    end

    result = []
    teams_all = Team.where('login_name not like ?', 'test%')
    teams_all.each do |team|
      result.push({
        schedule_team_id: team.id,
        name: team.name,
        score: score_map[team.id] || {},
      })
    end

    render json: {team: result, problem: problem_map}
  end

  def problems
    result = {}

    images = RunnerMaster::get_images
    teams = Team.all
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
        teams.each do |team|
          result[problem.id][:round][round.id] = {}
          image = find_image(images, team.login_name, problem.exploit_container_name, round.start_at)
          next if image.nil?
          score = image_to_score[image['digest']]
          next if score.nil?

          # calc score
          calclated_score = score.calc_score(problem.calc_formula)
          next if calclated_score.nil?

          result[problem.id][:round][round.id][score.runner_round_id] = calclated_score
        end
      end
    end

    render json: result
  end

  def score
    score = Score.where(runner_round_id: params[:id]).first
    problem = Problem.where(exploit_container_name: score.problem_name).first
    team = Team.where(login_name: score.team_login_name).first
    calclated_score = score.calc_score(problem.calc_formula)
    render json: {
      team: {
        team_id: team.login_name,
        name: team.name
      },
      problem: {
        name: problem.title,
        round_id: 'TBD',
        ntrials: problem.ntrials,
        succeeded: score.succeeded,
        score: calclated_score
      }
    }
  end

  private
  def find_image(images, team, problem, before_at)
    images
      .sort { |a, b| b['CreatedAt'] <=> a['CreatedAt'] } # find latest image
      .find { |image|
        (image['team'] == team && image['problem'] == problem &&
          Time.parse(image['CreatedAt']).to_i <= before_at.to_i)
      }
  end
end
