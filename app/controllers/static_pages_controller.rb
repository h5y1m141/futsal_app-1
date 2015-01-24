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

		@events_ochiai = Event.where(place_id: 1)
		@events_nerima = Event.where(place_id: 2) 
		@events_toshimaen = Event.where(place_id: 3)

	end

	def place
		@places_ochiai = Place.where(id: 1)
		@places_nerima = Place.where(id: 2)
		@places_toshimaen = Place.where(id: 3)
	end

	def about
	end

	def contact
	end

	def news
	end

	def ochiai
		@events_ochiai = Event.where(place_id: 1)
		@pages_ochiai = Page.all
	end

	def toshimaen
		@events_toshimaen = Event.where(place_id: 2)
		@pages_toshimaen = Page.all
	end

	def nerima
		@events_nerima = Event.where(place_id: 3)
		@pages_nerima = Page.all
	end
end
