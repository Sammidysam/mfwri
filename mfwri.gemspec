Gem::Specification.new do |gem|
	gem.name = "mfwri"
	gem.version = "0.0.1"
	gem.summary = "A Ruby Makefile writer."
	gem.authors = ["Sam Craig"]
	gem.email = "sammidysam@gmail.com"
	gem.files = ["Rakefile"] + Dir.glob("lib/**/*.rb") + Dir.glob("bin/*")
	gem.require_paths = ["lib"]
	#gem.homepage = "http://sammidysam.github.io/2013/08/01/mfjen.html"
	gem.license = "gpl-3.0"
end
