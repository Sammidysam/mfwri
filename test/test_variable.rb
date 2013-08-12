require "minitest/autorun"
require "mfwri"

class VariableTest < Minitest::Test
	def setup
		@variable = Mfwri::Variable.new("TESTVARIABLE")
	end

	# test changing all the options
	def test_only_name
		assert_equal @variable.to_s, "TESTVARIABLE=\n\n"
	end

	def test_no_blank_line
		@variable.blank_line_after = false

		assert_equal @variable.to_s, "TESTVARIABLE=\n"

		@variable.blank_line_after = true
	end

	def test_value
		@variable.value = "foobarfoo"

		assert_equal @variable.to_s, "TESTVARIABLE=foobarfoo\n\n"

		@variable.value = nil
	end

	def test_expand
		@variable.expand = true

		assert_equal @variable.to_s, "TESTVARIABLE:=\n\n"

		@variable.expand = false
	end

	def test_name
		@variable.name = "TESTNAME"

		assert_equal @variable.to_s, "TESTNAME=\n\n"

		@variable.name = "TESTVARIABLE"
	end

	# test all the constructors
	def test_con_no_name_given
		assert_raises(ArgumentError) { Mfwri::Variable.new }
	end
	
	def test_con_name_blank_line_after
		var = Mfwri::Variable.new("TESTVAR", :blank_line_after => false)

		assert_equal var.to_s, "TESTVAR=\n"
	end

	def test_con_name_value
		var = Mfwri::Variable.new("TESTVAR", :value => "TESTVALUE")

		assert_equal var.to_s, "TESTVAR=TESTVALUE\n\n"
	end

	def test_con_name_expand
		var = Mfwri::Variable.new("TESTVAR", :expand => true)

		assert_equal var.to_s, "TESTVAR:=\n\n"
	end
end
