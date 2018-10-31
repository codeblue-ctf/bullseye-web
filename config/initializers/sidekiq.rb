Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
  config.average_scheduled_poll_interval = 5
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
end

# initialize for all job on restarting
begin
  Schedule.all.each do |record|
    delete_job(record.id)
    ScheduleWorker.perform_async record.id
  end
rescue
end