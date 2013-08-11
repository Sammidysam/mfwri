module Mfwri
	class Makefile
		attr_accessor :location
	
		attr_accessor :variables
		attr_accessor :tasks
	
		def initialize(options = {})
			@location = options[:location] || "Makefile"
			
			@variables = options[:variables] || Array.new
			@tasks = options[:tasks] || Array.new
		end
		
		def to_s
			makefile_string = "# Makefile written with mfwri\n\n"
			
			@variables.each do |var|
				makefile_string << var.to_s
			end
			
			@tasks.each do |task|
				makefile_string << task.to_s
			end
			
			makefile_string
		end
	
		def write
			if File.exist?(@location)
				puts "File #{@location} already exists!  Aborting!"
				exit -1
			end
		
			File.open @location, 'w' do |file|
				file.puts(to_s)
			end
		end
	end
end
