require "mfwri/makefile_object"

module Mfwri
	class Variable < MakefileObject
		attr_accessor :value
		attr_accessor :expand
		
		def initialize(name, options = {})
			super(name, options[:blank_line_after] || true)
			
			@value = options[:value] || nil
			@expand = options[:expand] || false
		end
		
		def to_s
			"#{@name}" + (@expand ? ":=" : "=") + "#{@value}\n" + super
		end
	end
end
