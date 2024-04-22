require 'httparty'

api_key = 'd5def9d671777e124dd895229f477d9d'
city = 'Memphis'
url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric"
response = HTTParty.get(url)
weather_data = response.parsed_response

temperature = weather_data['main']['temp']
humidity = weather_data['main']['humidity']
weather_condition = weather_data['weather'][0]['description']

puts "Current weather in #{city}:"
puts "Temperature: #{temperature}°C"
puts "Humidity: #{humidity}%"
puts "Weather Condition: #{weather_condition}"

average_temperature = 0

# Fetch hourly temperature data for the past 24 hours
(0..23).each do |hour|
  # Construct the URL for fetching historical weather data for the specified hour
  url = "http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=40.7128&lon=-74.0060&dt=#{Time.now.to_i - hour * 3600}&appid=#{api_key}&units=metric"
  response = HTTParty.get(url)
  weather_data = response.parsed_response
  
  # Extract the temperature data for the specified hour
  temperature = weather_data['hourly'][0]['temp'] if weather_data && weather_data['hourly'] && !weather_data['hourly'].empty?
  
  # Add the temperature to the running total
  average_temperature += temperature.to_f if temperature
end

# Calculate the average temperature
average_temperature /= 24

puts "Average temperature in #{city} over the past 24 hours: #{average_temperature.round(2)}°C"