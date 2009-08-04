module Spec
  module Macroscopic
    module ExampleGroupMethods
      def macro(*args, &block)
        macro_definitions.push(args, block)
      end

      def it(*args, &block)
        if block
          super
        else
          macro_definitions.call(*args)
        end
      end

      def macro_definitions
        @macro_definitions ||= Macroscopic::Definitions.new
      end
    end
  end
end