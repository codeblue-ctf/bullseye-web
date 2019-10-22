require './lib/runner_master'

namespace :sync_data do
  task :fetch_result => :environment do
    # fetch all result data
    results = RunnerMaster::get_results

    # store results 
    results.each do |result|
      score = Score.where(runner_result_id: result[:id]).first_or_initialize
      score.runner_result_id = result[:id]
      score.image_digest = result[:exploit_hash] # XXX: we can't fetch this parameter yet
      score.succeeded = result[:succeeded]
      score.failed = result[:ntrials] - result[:succeeded]
      score.runner_started_at = result[:start_at]
      score.log = result.to_json
      score.save
    end
  end
end
