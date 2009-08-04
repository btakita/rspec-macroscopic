module Spec
  module Macroscopic
    class Definitions
      attr_reader :example_group
      def initialize(example_group)
        @example_group = example_group
      end

      def push(args, implementation)
        all << [args, implementation]
      end

      def call(*call_args)
        all.each do |definition|
          definition_args, implementation = definition
          next unless definition_args.length == call_args.length

          catch :no_match do
            implementation_args = []
            definition_args.each_with_index do |name_arg, i|
              if name_arg.is_a?(String)
                throw(:no_match) unless name_arg == call_args[i]
              else
                implementation_args << call_args[i]
              end
            end
            return implementation.call(*implementation_args)
          end
        end
        raise_macro_not_found_error(call_args) unless example_group.superclass.respond_to?(:macro_definitions)
        begin
          example_group.superclass.macro_definitions.call(*call_args)
        rescue MacroNotFoundError
          raise_macro_not_found_error(call_args)
        end
      end
      
      protected

      def raise_macro_not_found_error(call_args)
        raise MacroNotFoundError, call_args.inspect
      end

      def all
        @all ||= []
      end
    end
  end
end