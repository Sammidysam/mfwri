require "mfwri/makefile_object"

module Mfwri
	class Variable < MakefileObject
		attr_accessor :value
		attr_accessor :expand
		
		def initialize(name, options = {})
			super(name, options[:blank_line_after] || true)
			
			@value = options[:value] or nil
			@expand = options[:expand] or false
		end
		
		def to_s
			"#{@name}" + (@expand ? ":=" : "=") + "#{@value}" + super
		end
	end
end
