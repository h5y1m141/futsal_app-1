# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

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
