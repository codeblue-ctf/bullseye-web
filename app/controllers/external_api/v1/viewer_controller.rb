class ExternalApi::V1::ViewerController < ExternalApiController
  def teams
    score_map = {}
    schedule_results_all = ScheduleResult.includes(:schedule)
    schedule_results_all.each do |schedule_result|
      key = schedule_result.schedule.team_id
      score_map[key] ||= {}
      score_map[key][schedule_result.id] = schedule_result.score
    end

    result = []
    teams_all = Team.where('login_name not like ?', 'test%')
    teams_all.each do |team|
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
    schedule_results_all = ScheduleResult.joins(schedule: [:problem, :team]).where("teams.login_name not like ?", "test%")
    schedule_results_all.each do |schedule_result|
      result[schedule_result.schedule.problem_id] ||= {}
      result[schedule_result.schedule.problem_id][:name] = schedule_result.schedule.problem.title
      result[schedule_result.schedule.problem_id][:round] ||= {}
      result[schedule_result.schedule.problem_id][:round][schedule_result.round_id] ||= {}
      result[schedule_result.schedule.problem_id][:round][schedule_result.round_id][schedule_result.schedule.team_id] = schedule_result.id
    end

    render json: result
  end

  def score
    schedule_results = ScheduleResult.includes(schedule: [:team, :problem]).find_by(id: params[:id])
    render json: schedule_results ? {
      team: {
        team_id: schedule_results.schedule.team.login_name,
        name: schedule_results.schedule.team.name
      },
      problem: {
        name: schedule_results.schedule.problem.title,
        round_id: schedule_results.round_id,
        ntrials: schedule_results.schedule.problem.ntrials,
        succeeded: schedule_results.succeeded,
        score: schedule_results.score
      }
    } : nil
  end
end
