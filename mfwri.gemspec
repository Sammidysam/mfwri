Gem::Specification.new do |gem|
	gem.name = "mfwri"
	gem.version = "0.1.0"
	gem.summary = "A Ruby Makefile writer."
	gem.authors = ["Sam Craig"]
	gem.email = "sammidysam@gmail.com"
	gem.files = ["Rakefile"] + Dir.glob("lib/**/*.rb") + Dir.glob("bin/*")
	#gem.homepage = "http://sammidysam.github.io/2013/08/01/mfjen.html"
	gem.license = "gpl-3.0"
end
