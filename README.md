To run this app simply type ```ruby WeatherApp.rb <city> <country>```. You'll receive the current conditions for the given 
location.


In this app I use nokogiri gem to obtain the ISO 3166 country codes (as this is the standard required by openweathermap). 
It just simply crawls the wikipedia article and fetches the data enclosed in a HTML table on the page. I parse the HTML with 
Nokogiri::HTML. Then I extract the desired data using xpath method and store the results in a hash map. Afterward I search 
for the key that fits the input argument. In the end I fetch the JSON with weather data and parse it with the JSON class.
