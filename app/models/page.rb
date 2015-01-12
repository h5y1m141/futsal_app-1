class Page < ActiveRecord::Base
	validates :ochiai_url, uniqueness: true
	validates :nerima_url, uniqueness: true
	validates :toshimaen_url, uniqueness: true
end
