require "bundler/setup"
require "nokogiri"
require "open-uri"
require "active_record"
require 'activerecord-import/base'

namespace :crawler do
  desc "crawl_futsalinfo"
  task :futsal_info => :environment do
    def run(last_page=3)
      (1..last_page).each do |page|
        main_url = [{
           ochiai_url: "http://labola.jp/reserve/shop/2013/menu/personal/#{page}",
           nerima_url: "http://labola.jp/reserve/shop/785/menu/personal/#{page}",
           toshimaen_url: "http://labola.jp/reserve/shop/880/menu/personal/#{page}"
        }]

        main_url.each do |main|
          fetch_ochiai_url(main[:ochiai_url])
          fetch_nerima_url(main[:nerima_url])
          fetch_toshimaen_url(main[:toshimaen_url])
          sleep 3
          persist
        end
      end
    end

    def parse(main)
      @list = []
      @page_source = open(main)
      doc = Nokogiri::HTML.parse(@page_source,nil)
      doc.css("table.blue_table > tr").each do |elem|
        elem.css("td > a").each do |o|
          @list.push "http://labola.jp#{o[:href]}"
        end
      end
    end

    def fetch_ochiai_url(main)
      @ochiai_list = []
      parse(main)
      @ochiai_list = @list
    end

    def fetch_nerima_url(main)
      @nerima_list = []
      parse(main)
      @nerima_list = @list
    end

    def fetch_toshimaen_url(main)
      @toshimaen_list = []
      parse(main)
      @toshimaen_list = @list
    end

    private

    def persist
      @ochiai_list.zip(@nerima_list,@toshimaen_list).each do |ochiai_page,nerima_page,toshimaen_page|
        Page.create(ochiai_url: ochiai_page,nerima_url: nerima_page,toshimaen_url: toshimaen_page)
      end
    end
    run
  end
end



#    items = Page.all
#
#    items.each do |item|
#      page_source = open(item.ochiai_url)
#      doc = Nokogiri::HTML.parse(page_source,nil)
#      doc.css("table.blue_table").each do |elem|
#        elem.css("tr:nth-child(5) > td").each do |o|
#          detail = o.text.scan(/[\d\-]+/)
#          elem.css("tr:nth-child(2) > td").each do |x|
#            elem.css("tr:nth-child(1) > td > b").each do |y|
#              Event.create(place_id: 1,spot: "落合南長崎",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)
#
#              page_source = open(item.nerima_url)
#              doc = Nokogiri::HTML.parse(page_source,nil)
#              doc.css("table.blue_table").each do |elem|
#                elem.css("tr:nth-child(5) > td").each do |o|
#                  detail = o.text.scan(/[\d\-]+/)
#                  elem.css("tr:nth-child(2) > td").each do |x|
#                    elem.css("tr:nth-child(1) > td > b").each do |y|
#                      Event.create(place_id: 2,spot: "練馬",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)
#
#                      page_source = open(item.toshimaen_url)
#                      doc = Nokogiri::HTML.parse(page_source,nil)
#                      doc.css("table.blue_table").each do |elem|
#                        elem.css("tr:nth-child(5) > td").each do |o|
#                          detail = o.text.scan(/[\d\-]+/)
#                          elem.css("tr:nth-child(2) > td").each do |x|
#                            elem.css("tr:nth-child(1) > td > b").each do |y|
#                              Event.create(place_id: 3,spot: "豊島園",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)
#                            end
#                          end
#                        end
#                      end
#
#                    end
#                  end
#                end
#              end
#
#            end
#          end
#        end
#      end
#    end 
#    class Page < ActiveRecord::Base
#      def self.sweep(time = 5.minutes, old = 5.minutes)
#        if time.is_a?(String)
#          time = time.split.inject { |count, unit| count.to_i.send(unit) }
#        end
#
#        if old.is_a?(String)
#          old = old.split.inject { |count, unit| count.to_i.send(unit) }
#        end
#
#        delete_all "updated_at < '#{time.ago.to_s(:db)}' OR created_at < '#{old.ago.to_s(:db)}'"
#      end
#      sweep
#    end
#
#  end
#end
