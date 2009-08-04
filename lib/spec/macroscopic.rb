dir = File.dirname(__FILE__)
require "#{dir}/macroscopic/example_group_methods"

module Spec
  ExampleGroup.class_eval do
    extend Macroscopic::ExampleGroupMethods
  end
end
