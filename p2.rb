require 'httparty'

api_key = '1ccea20a0b7b9a5621b0c617' 
source_currency = 'USD'
target_currency = 'EUR'

url = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{source_currency}/#{target_currency}"
response = HTTParty.get(url)
exchange_rate_data = response.parsed_response
exchange_rate = exchange_rate_data['conversion_rate']

amount = 100
converted_amount = amount * exchange_rate
puts "#{amount} #{source_currency} is equivalent to #{converted_amount.round(2)} #{target_currency}"
