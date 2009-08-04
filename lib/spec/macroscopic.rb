dir = File.dirname(__FILE__)
require "#{dir}/macroscopic/macros"
require "#{dir}/macroscopic/example_group_methods"

module Spec
  module Macroscopic
    class MacroNotFoundError < ArgumentError
    end
  end

  ExampleGroup.class_eval do
    extend Macroscopic::ExampleGroupMethods
  end
end
