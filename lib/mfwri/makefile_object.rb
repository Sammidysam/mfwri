module Mfwri
	class MakefileObject
		attr_accessor :blank_line_after
		attr_accessor :name
		
		def initialize(name, blank_line_after = true)
			@name = name
			@blank_line_after = blank_line_after
		end
		
		def to_s
			@blank_line_after ? "\n\n" : "\n"
		end
	end
end
