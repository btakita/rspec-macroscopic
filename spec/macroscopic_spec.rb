require "#{File.dirname(__FILE__)}/spec_helper"

describe "Macrscopic Rspec" do
  describe "One argument macro" do
    already_run = false
    it "runs a simple macro" do
      return if already_run
      already_run = true
      
      simple_macro_invoked = false
      example_group.instance_eval do
        macro "runs a simple macro" do
          it "runs" do
            simple_macro_invoked = true
          end
        end

        it "runs a simple macro"
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))
      
      simple_macro_invoked.should be_true
    end
  end

  def example_group
    self.class
  end
end