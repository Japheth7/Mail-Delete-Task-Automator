class Main 
	require 'gmail'
	attr_reader :gmail

	def initialize(gmail)
		@gmail = gmail
	end

	class Config
		@@actions = ['read','unread','delete','quit']

		def self.actions
			@@actions
		end
	end
	
	def launch!
		result = nil
		introduction
		#get user input(action) until the action = quit
		until result == :quit
			action = get_action
			result = do_action(action)
		end
		conclusion
	end

	def get_action
		action = nil
		until Main::Config.actions.include?(action)
			puts "Actions: "+ Main::Config.actions.join(",") if action
			print ">"
			user_response = gets.chomp
			action = user_response.downcase.strip
		end
		return action
	end

	def do_action(action)
		case action
		when "read"
			read
		when "unread"
			unread
		when "delete"
			delete
		when "quit"
			return :quit
		else
			print "\n Command not understood."
		end
	end

	def read
		puts "\n Fetching read emails..."
		r_email = @gmail.inbox.count(:read)
		puts "\n You have " + r_email.to_s + " read emails"
	end

	def unread
		puts " \n Fetching unread emails..."
		ur_email = @gmail.inbox.count(:unread)
		puts "\n You have " + ur_email.to_s + " unread emails"
	end
	
	def delete
		puts "\n Deleting all unread emails"
		unread = gmail.inbox.emails(:unread, :before => Date.parse("2015-12-20"))
    	unread.each do |unread|
    		unread.delete!
    	end

    	puts ("Deletion complete")
	end

	def introduction	
		print "\n This app is in early development stage, it will kill your kitten and blow your computer!. \n\n"
	end




	def conclusion
		print "\n Okay, it didn't blow your computer but where is your kitten? \n\n"
	end


end
