#./lib/controller.rb
class Controller
attr_reader :name, :action
attr_accessor :status, :headers, :content

	def initialize(name: nil, action:nil)
		@name = name
		# Save the action to be called
		@action = action
	end

	def call
		# Call the action
		send(action)
		# Sends a 200 status for all successful calls
		self.status = 200
		# Sets content type
		self.headers = {"Content-Type" => "text/html"}
		# Pass a controller instance to template engine, variables defined in controller will 
		# be accessible in a template
		self.content = [template.render(self)]
		self
	end

	# Create the template object. pull view for controller and and action app/views/main/index.slim
	def template
		Slim::Template.new(File.join(App.root, 'app', 'views', "#{self.name}", "#{self.action}.slim"))
	end

	# Seperate method for 'not found' errors, it needs to return the controller not the content
	def not_found
		self.status = 404
		self.headers = {}
		self.content = ["Nothing Found"]
		self
	end

	# Seperate method for internal server '500' errors
	def internal_error
		self.status = 500
		self.headers = {}
		self.content = ["Internal error"]
		self
	end
end

