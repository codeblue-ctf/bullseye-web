class Image < ApplicationRecord
  def manifest?
    data = JSON.parse(event_log)
    media_type = data['target']['mediaType'] unless data.nil?
    media_type.starts_with? "application/vnd.docker.distribution.manifest"
  end
end
