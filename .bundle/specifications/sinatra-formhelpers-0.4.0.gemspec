# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sinatra-formhelpers"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nate Wiger"]
  s.date = "2011-08-26"
  s.description = "Simple, lightweight form helpers for Sinatra. Based on initial efforts by twilson63."
  s.email = "nate@wiger.org"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/nateware/sinatra-formhelpers"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Form helpers for Sinatra"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bacon>, [">= 0"])
    else
      s.add_dependency(%q<bacon>, [">= 0"])
    end
  else
    s.add_dependency(%q<bacon>, [">= 0"])
  end
end
