class Makefile
	@@location = ""
	
	@@variables = []
	@@tasks = []
	
	def initialize(location = "Makefile")
		@@location = location
	end
	
	def write
		if File.exist?(@@location)
			puts "File #{@@location} already exists!  Aborting!"
			exit -1
		end
		
		File.open default_name, 'w' do |file|
		
		end
	end
end
