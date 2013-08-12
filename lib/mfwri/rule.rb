require "mfwri/makefile_object"

module Mfwri
	class Rule < MakefileObject
		attr_accessor :prerequisites
		attr_accessor :recipe
		
		def initialize(name, options = {})
			super(name, options.has_key?(:blank_line_after) ? options[:blank_line_after] : true)
			
			@prerequisites = options.has_key?(:prerequisites) ? options[:prerequisites] : Array.new
			@recipe = options.has_key?(:recipe) ? options[:recipe] : Array.new
		end

		def add_prereq(prerequisite)
			copy = Marshal.load(Marhshal.dump(self))

			copy.prerequisites << prerequisite

			copy
		end

		def add_prereq!(prerequisite)
			@prerequisites << prerequisite
		end

		def add_recipe(line)
			copy = Marshal.load(Marshal.dump(self))

			copy.recipe << line

			copy
		end

		def add_recipe!(line)
			@recipe << line
		end

		def has_prereq?
			@prerequisites > 0
		end

		def has_recipe?
			@recipe > 0
		end

		def weird_prereqs?
			@prerequisites.each do |prereq|
				return true unless prereq.is_a?(Mfwri::Variable) and prereq.is_a?(String)
			end

			false
		end

		def weird_recipe?
			@recipe.each do |line|
				return true unless line.is_a?(String)
			end

			false
		end

		def weird?
			weird_prereqs? or weird_recipe?
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

			task_string << "\n"
			
			@recipe.each do |line|
				task_string << "\t#{line}\n"
			end
			
			task_string + super
		end
	end
end
