module Mfwri
	class Makefile
		attr_accessor :location
	
		attr_accessor :variables
		attr_accessor :rules
	
		def initialize(options = {})
			@location = options.has_key?(:location) ? options[:location] : "Makefile"
			
			@variables = options.has_key?(:variables) ? options[:variables] : Array.new
			@rules = options.has_key?(:rules) ? options[:rules] : Array.new
		end

		def add_var(variable)
			copy = Marshal.load(Marshal.dump(self))

			copy.variables << variable

			copy
		end

		def add_var!(variable) 
			@variables << variable
		end

		def add_rule(rule)
			copy = Marshal.load(Marshal.dump(self))

			copy.rules << rule

			copy
		end

		def add_rule!(rule)
			@rules << rule
		end

		def has_rule?
			@rules.size > 0
		end

		def has_var?
			@variables.size > 0
		end

		def weird_vars?
			@variables.each do |var|
				return true unless var.is_a?(Mfwri::Variable)
			end

			false
		end

		def weird_rules?
			@ruless.each do |rule|
				return true unless rule.is_a?(Mfwri::Rule)
			end

			false
		end
		
		def to_s
			makefile_string = "# Makefile written with mfwri\n\n"
			
			@variables.each do |var|
				makefile_string << var.to_s
				makefile_string << "\n" unless var.is_a?(Mfwri::Variable)
			end
			
			@rules.each do |rule|
				makefile_string << rule.to_s
				makefile_string << "\n" unless rule.is_a?(Mfwri::Rule)
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
