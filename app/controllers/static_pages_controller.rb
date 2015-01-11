require "nokogiri"
require "open-uri"
require "active_record"

class StaticPagesController < ApplicationController

	def home

	  @maps = Map.all
	  @hash = Gmaps4rails.build_markers(@maps) do |user, marker|
		  marker.lat user.latitude
		  marker.lng user.longitude
		  marker.infowindow user.description
	  end

		@events = Event.where(place_id: 1)

	end

	def place
		@places = Place.all
	end

	def about
	end

	def contact
	end

	def news
	end

	def ochiai
		@events = Event.where(place_id: 1)
	end
    

	def toshimaen
		@events = Event.where(place_id: 2)
	end

	def nerima
		@events = Event.where(place_id: 3)
	end
end    
