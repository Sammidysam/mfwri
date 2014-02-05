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

		@rule.clear_prereqs!
	end

	def test_prereq_only_string
		var = "TESTVAR"

		@rule.add_prereq! var

		assert_equal @rule.to_s, "all: $(TESTVAR)\n\n"

		@rule.clear_prereqs!
	end

	def test_prereq_multiple_vars
		vars = Array.new(3)

		vars.each_with_index do |var, index|
			var = Mfwri::Variable.new("TESTVAR#{index}")
			@rule.add_prereq! var
		end

		assert_equal @rule.to_s, "all: $(TESTVAR0) $(TESTVAR1) $(TESTVAR2)\n\n"

		@rule.clear_prereqs!
	end

	def test_prereq_multiple_strings
		strings = Array.new(3)

		strings.each_with_index do |string, index|
			string = "TESTSTRING#{index}"
			@rule.add_prereq! string
		end

		assert_equal @rule.to_s, "all: $(TESTSTRING0) $(TESTSTRING1) $(TESTSTRING2)\n\n"

		@rule.clear_prereqs!
	end

	def test_prereq_variable_string
		var = Mfwri::Variable.new("TESTVAR")
		string = "TESTSTRING"

		@rule.add_prereq! var
		@rule.add_prereq! string

		assert_equal @rule.to_s, "all: $(TESTVAR) $(TESTSTRING)\n\n"

		@rule.clear_prereqs!
	end

	def test_weird_prereq
		normal = Array.new(2)

		normal[0] = Mfwri::Variable.new("TESTVAR")
		normal[1] = "TESTSTRING"

		weird = 17

		normal.each { |prereq| @rule.add_prereq!(prereq) } 
		@rule.add_prereq! weird

		assert @rule.weird_prereqs?

		@rule.clear_prereqs!
	end

	def test_recipe_one_line
		@rule.add_recipe_line! "gcc -c -o hi.o hi.c"

		assert_equal @rule.to_s, "all:\n\tgcc -c -o hi.o hi.c\n\n"

		@rule.clear_recipe!
	end

	def test_recipe_multiple_lines
		lines = Array.new(2)

		lines[0] = "gcc -c -o hi.o hi.c"
		lines[1] = "gcc -o hi hi.o"
		lines.each { |line| @rule.add_recipe_line!(line) }

		assert_equal @rule.to_s, "all:\n\tgcc -c -o hi.o hi.c\n\tgcc -o hi hi.o\n\n"

		@rule.clear_recipe!
	end
end
