require "mfwri/makefile_object"

module Mfwri
	class Rule < MakefileObject
		attr_accessor :prerequisites
		attr_accessor :recipe
		
		def initialize(name, options = {})
			super(name, options[:blank_line_after] || true)
			
			@prerequisites = options[:prerequisites] || Array.new
			@recipe = options[:recipe] || Array.new
		end
		
		def to_s
			task_string = "#{@name}:"
			
			if @prerequisites.size > 0
				task_string << " "
				
				@prerequisites.each do |dep|
					task_string << (dep.is_a?(String) ? (dep.include?('$') ? "#{dep} " : "$(#{dep}) ") : "$(#{dep.name}) ")
				end
				
				# remove last character if necessary
				task_string = task_string[0...-1] if task_string[-1] == ' '
			end
			
			if @recipe.size > 0
				task_string << "\n"
				
				@recipe.each do |line|
					task_string << "\t#{line}\n"
				end
			end
			
			task_string + super
		end
	end
end
