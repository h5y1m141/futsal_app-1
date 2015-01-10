# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
require "nokogiri"
require "open-uri"
require "active_record"

for i in 1..3
  ochiai_url = "http://labola.jp/reserve/shop/2013/menu/personal/#{i}"
  page_source = open(ochiai_url)
  doc = Nokogiri::HTML.parse(page_source,nil)
  doc.css("table.blue_table > tr").each do |elem|
    elem.css("td > a").each do |o|

			nerima_url = "http://labola.jp/reserve/shop/785/menu/personal/#{i}"
      page_source = open(nerima_url)
      doc = Nokogiri::HTML.parse(page_source,nil)
      doc.css("table.blue_table > tr").each do |elem2|
        elem2.css("td > a").each do |n|

					toshimaen_url = "http://labola.jp/reserve/shop/880/menu/personal/#{i}"
          page_source = open(toshimaen_url)
          doc = Nokogiri::HTML.parse(page_source,nil)
          doc.css("table.blue_table > tr").each do |elem3|
            elem3.css("td > a").each do |t|
							Page.create(:ochiai_url => "http://labola.jp#{o[:href]}",:nerima_url => "http://labola.jp#{n[:href]}",:toshimaen_url => "http://labola.jp#{t[:href]}")
						end
          end
				end  
		  end
    end
  end
end


    
items = Page.find(1,2,3)

items.each do |item| 
  page_source = open(item.ochiai_url)
  doc = Nokogiri::HTML.parse(page_source,nil)
  doc.css("table.blue_table").each do |elem|
	  elem.css("tr:nth-child(5) > td").each do |o|
	    detail = o.text.scan(/[\d\-]+/)
	    elem.css("tr:nth-child(2) > td").each do |x|
		    elem.css("tr:nth-child(1) > td > b").each do |y|
				  Event.create(:place_id => 1,:participants => detail[0],:unoccupied_seats => detail[1],:start_date => x.text,:name => y.text)
		    end
	    end
    end
  end
end

