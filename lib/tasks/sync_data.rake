require './lib/runner_master'

namespace :sync_data do
  task :fetch_result => :environment do
    # fetch all result data
    rounds = RunnerMaster::get_rounds

    # store results 
    rounds.each do |round|
      next if round[:results].size == 0

      # use latest result
      result = round[:results].sort{ |a, b| b[:CreatedAt] <=> a[:CreatedAt] }[0]

      score = Score.where(runner_round_id: round[:id]).first_or_initialize
      score.runner_round_id = round[:id]
      score.image_digest = round[:exploit_hash] # XXX: we can't fetch this parameter yet
      score.succeeded = result[:succeeded]
      score.failed = round[:ntrials] - result[:succeeded]
      score.runner_started_at = round[:start_at]
      score.log = round.to_json
      score.save
    end
  end
end
