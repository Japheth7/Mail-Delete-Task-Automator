APP_ROOT = File.dirname(__FILE__)

#look for required files in the lib folder
$:.unshift (File.join(APP_ROOT,'lib'))

require 'main'


#get credentials
print "Enter your email: "
username = gets.chomp.strip

print"Enter your password: "
password = gets.chomp.strip

gmail = Gmail.new(username,password)

main = Main.new(gmail)
#launch the app
main.launch!