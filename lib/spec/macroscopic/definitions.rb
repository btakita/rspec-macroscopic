module Spec
  module Macroscopic
    class Definitions
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
        raise MacroNotFoundError, call_args.inspect
      end
      
      protected

      def all
        @all ||= []
      end
    end
  end
end