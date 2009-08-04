module Spec
  module Macroscopic
    module ExampleGroupMethods
      def macro(*args, &block)
        (class << self; self; end).class_eval do
          define_method(args.map {|arg| arg.to_s}.join("_"), &block)
        end
      end

      def it(*args, &block)
        if block
          super
        else
          send(*args.join("_"))
        end
      end
    end
  end
end