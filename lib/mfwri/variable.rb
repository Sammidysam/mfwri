require "mfwri/makefile_object"

module Mfwri
	class Variable < MakefileObject
		attr_accessor :value
		attr_accessor :expand
		
		def initialize(name, options = {})
			super(name, options.has_key?(:blank_line_after) ? options[:blank_line_after] : true)
			
			@value = options.has_key?(:value) ? options[:value] : nil
			@expand = options.has_key?(:expand) ? options[:expand] : false
		end
		
		def to_s
			"#{@name}" + (@expand ? ":=" : "=") + "#{@value}\n" + super
		end
	end
end
