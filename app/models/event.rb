class Event < ActiveRecord::Base
	belongs_to :place
	validates :start_date, uniqueness: true
end
