require "nokogiri"
require "open-uri"
require "active_record"

namespace :event_info do
  desc "eventpage"
  task :store => :environment do

    def run
      fetch_ochiai
      fetch_nerima
      fetch_toshimaen
    end

    def parse
      doc = Nokogiri::HTML.parse(@page_source,nil)
      doc.css("table.blue_table").each do |elem|
        elem.css("tr:nth-child(5) > td").each do |o|
          @detail = o.text.scan(/[\d\-]+/)
          elem.css("tr:nth-child(2) > td").each do |x|
            @date = x.text
            elem.css("tr:nth-child(1) > td > b").each do |y|
              @title = y.text
            end
          end
        end
      end
    end

    def fetch_ochiai
      items = Page.all
      items.each do |item|
        @page_source = open(item.ochiai_url)
        parse
        Event.create(place_id: 1,spot: "落合南長崎",participants: @detail[0],unoccupied_seats: @detail[1],start_date: @date,:name => @title)
      end
    end

    def fetch_nerima
      items = Page.all
      items.each do |item|
        @page_source = open(item.nerima_url)
        parse
        Event.create(place_id: 2,spot: "練馬",participants: @detail[0],unoccupied_seats: @detail[1],start_date: @date,:name => @title)
      end
    end

    def fetch_toshimaen
      items = Page.all
      items.each do |item|
        @page_source = open(item.toshimaen_url)
        parse
        Event.create(place_id: 3,spot: "豊島園",participants: @detail[0],unoccupied_seats: @detail[1],start_date: @date,:name => @title)
      end
    end
    run
  end
end
