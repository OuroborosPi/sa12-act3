require 'httparty'

api_key = 'JeAcnAAEhZkCygcat6GmDa89T4yYa3Qz'
city = 'New York'
url = "https://app.ticketmaster.com/discovery/v2/events.json?city=#{city}&apikey=#{api_key}"
response = HTTParty.get(url)
events_data = response.parsed_response['_embedded']['events']

if events_data && !events_data.empty?
  events_data.each do |event|
    name = event['name']
    venue = event['_embedded']['venues'][0]['name']
    start_time = event['dates']['start']['localTime']

    puts "Event: #{name}"
    puts "Venue: #{venue}"
    puts "Start Time: #{start_time}"
    puts "----------------------------------------"
  end
else
  puts "No upcoming events found in #{city}."
end
