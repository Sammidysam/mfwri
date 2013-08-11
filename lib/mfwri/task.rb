require "mfwri/makefile_object"

module Mfwri
	class Task < MakefileObject	
		attr_accessor :dependencies
		attr_accessor :code
		
		def initialize(name, options = {})
			super(name, options[:blank_line_after] || true)
			
			@dependencies = options[:dependencies] || Array.new
			@code = options[:code] || Array.new
		end
		
		def to_s
			task_string = "#{@name}:"
			
			if @dependencies.size > 0
				task_string << " "
				
				@dependencies.each do |dep|
					task_string << (dep.is_a?(String) ? (dep.include?('$') ? "#{dep} " : "$(#{dep}) ") : "$(#{dep.name}) ")
				end
				
				# remove last character if necessary
				task_string = task_string[0...-1] if task_string[-1] == ' '
			end
			
			if @code.size > 0
				task_string << "\n"
				
				@code.each do |line|
					task_string << "\t#{line}\n"
				end
			end
			
			task_string + super
		end
	end
end
