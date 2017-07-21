#app/controllers/main_controller.rb
class MainController < Controller
	def index
		@test = "Some dump text here"
		@arr = %w(one two three)
		
	end
	def hello
		puts "hello world"
	end
end
