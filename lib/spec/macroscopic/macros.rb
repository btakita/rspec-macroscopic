module Spec
  module Macroscopic
    class Macros
      attr_reader :example_group
      def initialize(example_group)
        @example_group = example_group
      end

      def push(args, implementation)
        all << Macro.new(args, implementation)
      end

      def call(calling_example_group, *call_args)
        all.each do |macro|
          match, result = macro.match_andand_call(calling_example_group, *call_args)
          return result if match
        end
        call_superclasses(calling_example_group, *call_args)
      end

      protected

      def call_superclasses(calling_example_group, *call_args)
        raise_macro_not_found_error(call_args) unless example_group.superclass.respond_to?(:macro_definitions)
        begin
          example_group.superclass.macro_definitions.call(calling_example_group, *call_args)
        rescue MacroNotFoundError
          raise_macro_not_found_error(call_args)
        end
      end

      def raise_macro_not_found_error(call_args)
        raise MacroNotFoundError, call_args.inspect
      end

      def all
        @all ||= []
      end
    end
  end
end