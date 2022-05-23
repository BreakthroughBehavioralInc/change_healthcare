lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "change_healthcare/version"

Gem::Specification.new do |spec|
  spec.name          = "change_healthcare"
  spec.version       = ChangeHealthcare::VERSION
  spec.authors       = ["Saul Moncada"]
  spec.email         = ["smoncada@mdlive.com"]

  spec.summary       = %q{Api Client for ChangeHealthcare}
  spec.homepage      = "https://www.mdlive.com"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency    "rest-client", "~> 2"
  spec.add_runtime_dependency    "nokogiri", '>= 1'
  spec.add_runtime_dependency    "activesupport", '>= 6'
  spec.add_runtime_dependency    "rexml"

  spec.add_development_dependency "bundler", ">= 2.0"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rspec", ">= 3.0"
  spec.add_development_dependency "pry", ">= 0.10"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
