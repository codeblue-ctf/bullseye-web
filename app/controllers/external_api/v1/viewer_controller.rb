class ExternalApi::V1::ViewerController < ExternalApiController
  def teams
    score_map = {}
    schedule_results_all = ScheduleResult.includes(:schedule)
    schedule_results_all.each do |schedule_result|
      key = schedule_result.schedule.team_id
      score_map[key] ||= {}
      score_map[key][schedule_result.schedule_id] = schedule_result.score
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

  def problems
    result = {}
    schedules_all = Schedule.includes(:problem)
    schedules_all.each do |schedule|
      result[schedule.problem_id] ||= {}
      result[schedule.problem_id][:name] = schedule.problem.title
      result[schedule.problem_id][:round] ||= {}
      result[schedule.problem_id][:round][schedule.current_round] ||= {}
      result[schedule.problem_id][:round][schedule.current_round][schedule.team_id] = schedule.id
    end

    render json: result
  end

  def score
    schedule_results = ScheduleResult.includes(schedule: [:team, :problem]).find_by(schedule_id: params[:id])
    render json: schedule_results ? {
      team: {
        team_id: schedule_results.schedule.team.login_name,
        name: schedule_results.schedule.team.name
      },
      problem: {
        name: schedule_results.schedule.problem.title,
        round: schedule_results.schedule.current_round,
        ntrials: schedule_results.schedule.problem.ntrials,
        succeeded: schedule_results.succeeded,
        score: schedule_results.score
      }
    } : nil
  end
end
