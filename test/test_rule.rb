require "minitest/autorun"
require "mfwri"

class RuleTest < Minitest::Test
	def setup
		@rule = Mfwri::Rule.new("all")
	end
end
