module Spec
  module Macroscopic
    module ExampleGroupMethods
      def macro(*args, &block)
        macro_definitions.push(args, block)
      end

      def example(*args, &implementation)
        if implementation
          super
        else
          macro_definitions.call(self, *args)
        end
      end

      def it(*args, &implementation)
        example(*args, &implementation)
      end

      def specify(*args, &implementation)
        example(*args, &implementation)
      end

      def macro_definitions
        @macro_definitions ||= Macroscopic::Macros.new(self)
      end
    end
  end
end