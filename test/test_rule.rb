require "minitest/autorun"
require "mfwri"

class RuleTest < Minitest::Test
	def setup
		@rule = Mfwri::Rule.new("all")
	end

	def test_only_name
		assert_equal @rule.to_s, "all:\n\n"
	end

	def test_prereq_only_variable
		var = Mfwri::Variable.new("TESTVAR")

		@rule.add_prereq! var

		assert_equal @rule.to_s, "all: $(TESTVAR)\n\n"

		@rule.prerequisites = Array.new
	end

	def test_prereq_only_string
		var = "TESTVAR"

		@rule.add_prereq! var

		assert_equal @rule.to_s, "all: $(TESTVAR)\n\n"

		@rule.prerequisites = Array.new
	end

	def test_prereq_multiple_vars
		vars = Array.new(3)

		vars.each_with_index do |var, index|
			var = Mfwri::Variable.new("TESTVAR#{index}")
			@rule.add_prereq! var
		end

		assert_equal @rule.to_s, "all: $(TESTVAR0) $(TESTVAR1) $(TESTVAR2)\n\n"

		@rule.prerequisites = Array.new
	end

	def test_prereq_multiple_strings

	end
end
