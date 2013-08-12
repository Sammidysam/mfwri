require "minitest/autorun"
require "mfwri"

class MakefileTest < Minitest::Test
	def setup
		@makefile = Mfwri::Makefile.new
	end

	def test_write
		@makefile.write

		assert File.exists?("Makefile")

		File.delete("Makefile")
	end
end
