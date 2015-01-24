require "nokogiri"
require "open-uri"
require "active_record"

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
