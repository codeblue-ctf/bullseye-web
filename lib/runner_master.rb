require 'net/https'
require 'uri'

module RunnerMaster
  def self.runner_master_api_url(path)
    bullseye_config = Rails.application.config.bullseye
    URI("http://#{bullseye_config[:runner_master_host]}#{path}")
  end
  def self.post(path, data)
    uri = runner_master_api_url(path)
    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/json'
    req.body = data.to_json
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    JSON.parse(res.body)
  end
  def self.delete(path)
    uri = runner_master_api_url(path)
    req = Net::HTTP::Delete.new(uri)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    JSON.parse(res.body)
  end
  def self.get(path)
    uri = runner_master_api_url(path)
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    JSON.parse(res.body)
  end

  def self.create_schedule(schedule)
    post('/schedule', schedule)
  end
  def self.delete_schedule(schedule_id)
    delete("/schedule/#{schedule_id}")
  end
  def self.get_schedules
    get("/schedule")
  end
  def self.get_results
    get("/result")
  end
  def self.get_images
    get("/image")
  end
  def self.get_rounds
    get("/round")
  end
  def self.get_round_capture(runner_round_id)
    get("/round/capture/#{runner_round_id}")
  end
  def self.get_job_capture(job_id)
    uri = runner_master_api_url("/job/capture/#{job_id}")
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.host, uri.port) { |http|
      http.request(req)
    }
    res.body
  end
end
