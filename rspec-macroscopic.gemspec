# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-macroscopic}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Takita"]
  s.date = %q{2009-08-04}
  s.default_executable = %q{jeweler}
  s.description = %q{This library alters rspec, making it easier to use and create more expressive macros.}
  s.email = %q{brian.takita@gmail.com}
  s.executables = ["jeweler"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/spec/macroscopic.rb",
     "lib/spec/macroscopic/example_group_methods.rb",
     "lib/spec/macroscopic/macro.rb",
     "lib/spec/macroscopic/macros.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/btakita/rspec-macroscopic}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This library alters rspec, making it easier to use and create more expressive macros.}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/macroscopic_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
