class Problem < ApplicationRecord
  has_many :schedule

  validates :calc_formula, presence: true
  
  before_save do |record|
    if record.docker_compose_changed? then
      begin
        record.docker_compose % {
          team: "",
          exploit: "",
          problem: ""
        }
      rescue KeyError => e
        raise ActiveRecord::ValidationError, "#{e}"
      end
    end
  end
end
