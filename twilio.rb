#commit me  

require 'rubygems'
require 'twilio-ruby'
require 'pry'
require_relative 'user'
require_relative 'call'
require_relative 'weather'


=begin

@account_sid = 'AC40a62239206f477748434e421fd9ded1'
@auth_token = 'db47dea9d29602abebadfc821cac6d4c'
@to = '8315888084'
@from_twil = '8313594235'
#buy number
@body = 'Whats up JO000EEE!!!!'
# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(@account_sid, @auth_token)


@account = @client.account
@message = @account.sms.messages.create({:from => @from_twil, :to => @to, :body => @body})
puts @message

=end
##########################


	def create_user
		puts "Hello New User... \n"
		puts "What is your name? \n"  ## TODO -- CHECK IF STRING
		name = gets.strip
		if name.to_s.class == String
			@you = User.new(name)
		end
		if name.class == Fixnum
			create_user
		end
	end

	def call_user
		puts "Cool, can I text you, #{@you.name}   (y/n)?"
	  	call_me = gets.strip
	  	name = @you.name

		if call_me.upcase.include?("N") || call_me.upcase.include?("NO") 
			puts "You're no fun"
			create_user
		end
		if call_me.upcase.include?("Y") || call_me.upcase.include?("YES")  

			puts "Great, what is your cell phone number?"
			phone_number = gets.to_i

			if phone_number.to_s.length == 10

				puts "whats ur is your zip code?"
			  	zip_code = gets.to_i

			  	save_weather_info = Weather.new(zip_code)

			  	f = save_weather_info.get_forecast
			    message_body = f.first

			    text_me_now = Call.new(name, phone_number, message_body, zip_code)
			    text_me_now.make_call

			    puts "Check your phone now #{@you.name}"

			else puts "you must enter a 10 digit number"
				create_user
			end
		end
	end


puts "\n \n \n ******************  Welcome to the Console Forecast Text Messenger  ****************** \n \n \n"

some_user = create_user

text_me = call_user



