require 'json'
require 'nokogiri'
require 'pry'
require 'httparty'


city = ARGV[0]
state = ARGV[1]

page_countries = HTTParty.get('https://en.wikipedia.org/wiki/ISO_3166-1')

countries = Hash.new
parse_page = Nokogiri::HTML(page_countries)
parse_page.xpath('//table[@class = "wikitable sortable"]/tr').each do |row|
  first_column = row.xpath('td/a/text()')[0].to_s
  second_column = row.xpath('td/a/text()')[1].to_s.split(':')[1]
  countries.store(first_column, second_column)
end



state_code = countries.fetch(state)

url = "http://api.openweathermap.org/data/2.5/weather?q="+city+","+state_code+"&APPID=ad46873043deb8cfd273ebacca6b5a9f"
weather_raw = HTTParty.get(url).to_s
weather = JSON.parse(weather_raw)
puts "Description: #{weather["weather"].first.fetch("description")}"
puts "Temperature: #{weather["main"]["temp"] - 272.15}°C"
puts "Pressure: #{weather["main"]["pressure"]} hPa"
puts "Humidity: #{weather["main"]["humidity"]}%"
puts "Wind: #{weather["wind"]["speed"]} m/s"

#Pry.start(binding)
