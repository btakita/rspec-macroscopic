module Spec
  module Macroscopic
    class Macro
      attr_reader :definition_args, :implementation
      def initialize(definition_args, implementation)
        @definition_args, @implementation = definition_args, implementation
      end

      def match_andand_call(calling_example_group, *call_args)
        return [false, nil] unless definition_args.length == call_args.length

        catch :no_match do
          implementation_args = []
          definition_args.each_with_index do |name_arg, i|
            if name_arg.is_a?(String)
              throw(:no_match) unless name_arg == call_args[i]
            else
              implementation_args << call_args[i]
            end
          end
          return [true, calling_example_group.instance_exec(*implementation_args, &implementation)]
        end

        return [false, nil]
      end
    end
  end
end