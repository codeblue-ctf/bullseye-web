require './lib/runner_master'

namespace :sync_data do
  task :fetch_result => :environment do
    # fetch all result data
    rounds = RunnerMaster::get_rounds
    results = RunnerMaster::get_results

    # store results 
    rounds.each do |round|
      round_results = results.filter { |result| result['round_id'] == round['ID'] }
      next if round_results.size == 0

      # use latest result
      result = round_results.sort{ |a, b| b['CreatedAt'] <=> a['CreatedAt'] }[0]

      score = Score.where(runner_round_id: round['ID']).first_or_initialize
      score.runner_round_id = round['ID']
      score.image_digest = round['image_hash']
      score.succeeded = result['succeeded']
      score.failed = result['executed'] - result['succeeded']
      score.executed = result['executed']
      score.runner_started_at = round['start_at']
      score.team_login_name = round['team']
      score.problem_name = round['exploit_container']
      score.log = round.to_json
      score.save
    end
  end
end
