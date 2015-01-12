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
#require "activerecord-import/base"
##require "pry"

for i in 1..3
  ochiai_url = "http://labola.jp/reserve/shop/2013/menu/personal/#{i}"
  page_source = open(ochiai_url)
  doc = Nokogiri::HTML.parse(page_source,nil)
  doc.css("table.blue_table > tr").each do |elem|
    elem.css("td > a").each do |o|

      nerima_url = "http://labola.jp/reserve/shop/785/menu/personal/#{i}"
      page_source = open(nerima_url)
      doc = Nokogiri::HTML.parse(page_source,nil)
      doc.css("table.blue_table > tr").each do |elem|
        elem.css("td > a").each do |n|
                        
          toshimaen_url = "http://labola.jp/reserve/shop/880/menu/personal/#{i}"
          page_source = open(toshimaen_url)
          doc = Nokogiri::HTML.parse(page_source,nil)
          doc.css("table.blue_table > tr").each do |elem|
            elem.css("td > a").each do |t|

              Page.create(ochiai_url: "http://labola.jp#{o[:href]}",nerima_url: "http://labola.jp#{n[:href]}",toshimaen_url: "http://labola.jp#{t[:href]}")

            end
          end
        end
      end
    end
  end
end


  
tems = Page.all

tems.each do |item|
 page_source = open(item.ochiai_url)
 doc = Nokogiri::HTML.parse(page_source,nil)
 doc.css("table.blue_table").each do |elem|
   elem.css("tr:nth-child(5) > td").each do |o|
     detail = o.text.scan(/[\d\-]+/)
     elem.css("tr:nth-child(2) > td").each do |x|
       elem.css("tr:nth-child(1) > td > b").each do |y|
         Event.create(place_id: 1,spot: "落合南長崎",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)

           page_source = open(item.nerima_url)
           doc = Nokogiri::HTML.parse(page_source,nil)
           doc.css("table.blue_table").each do |elem|
             elem.css("tr:nth-child(5) > td").each do |o|
               detail = o.text.scan(/[\d\-]+/)
               elem.css("tr:nth-child(2) > td").each do |x|
                 elem.css("tr:nth-child(1) > td > b").each do |y|
                   Event.create(place_id: 2,spot: "練馬",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)

                     page_source = open(item.toshimaen_url)
                     doc = Nokogiri::HTML.parse(page_source,nil)
                     doc.css("table.blue_table").each do |elem|
                       elem.css("tr:nth-child(5) > td").each do |o|
                       detail = o.text.scan(/[\d\-]+/)
                         elem.css("tr:nth-child(2) > td").each do |x|
                           elem.css("tr:nth-child(1) > td > b").each do |y|
                             Event.create(place_id: 3,spot: "豊島園",participants: detail[0],unoccupied_seats: detail[1],start_date: x.text,:name => y.text)
                           end
                         end
                       end
                     end

                 end
               end
             end
           end

       end
     end
   end
 end
nd


Place.create([
				 { name: "BONFIM Football Park 落合南長崎",address: "東京都豊島区南長崎4丁目5番20号　i-Terrace 5F",price: "1030円〜",description: "落合南長崎駅" },
				 { name: "練馬フットボールパーク" ,address: "東京都練馬区田柄1-5-8",price: "1100円〜",description: "練馬春日町駅" },
				 { name: "フィスコフットサルアレナとしまえん" ,address: "東京都練馬区向山3-25-1　としまえん屋内館",price: "1100円〜",description: "豊島園駅" }
            ])

Map.create([
				 { title: "落合南長崎" ,description: "BONFIM Football Park 落合南長崎" ,address: "落合南長崎" ,latitude: 35.724333 ,longitude: 139.682639 },
				 { title: "練馬",description: "練馬フットボールパーク" ,address: "練馬" ,latitude: 35.757857,longitude: 139.641941 },
				 { title: "豊島園",description: "フィスコフットサルアレナとしまえん" ,address: "豊島園" ,latitude: 35.743331,longitude: 139.647713 }
           ])


