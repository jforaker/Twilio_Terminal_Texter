require 'rest-client'
require 'json'

class Weather

	attr_accessor :zip_code

	def initialize(zip_code)
		@zip_code = zip_code
	end

	def zip_code
		@zip_code
	end

	def get_data
		response = JSON.load RestClient.get "http://api.worldweatheronline.com/free/v1/weather.ashx", 
				:params => {
					:q => @zip_code, 
					:format => "json", 
					:num_of_days => "1", 
					:key => "wa9qapf6p6m9sm5mjkj7quhn"
				}
		#puts response
		response["data"]["current_condition"].map do |item|
	  		s = {forecast: item["temp_F"]}
	  		forecast(s)
	  	end
  	
	end	

	def forecast item
		@degrees = "#{item[:forecast]}"
		if @degrees.to_i < 70
			"you better bring a jacket, it is going to be #{@degrees} degrees today."
		else
			"grab your sunscreen, it's going to be #{@degrees} degrees today."
		end
	end

	def get_forecast
		get_data
	end
end
