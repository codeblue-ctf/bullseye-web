Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
  config.average_scheduled_poll_interval = 1
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
end

# initialize for all job on restarting
Schedule.all.each do |record|
  ScheduleWorker.perform_async record.id
end
