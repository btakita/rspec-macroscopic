require "#{File.dirname(__FILE__)}/spec_helper"

describe "Macrscopic Rspec" do
  describe "Single name macro" do
    already_run = false
    it "runs a single name macro" do
      return if already_run
      already_run = true
      
      single_name_macro_invoked = false
      example_group.instance_eval do
        macro "runs a single name macro" do
          it "runs" do
            single_name_macro_invoked = true
          end
        end

        it "runs a single name macro"
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))
      
      single_name_macro_invoked.should be_true
    end
  end

  describe "Multi name macro" do
    already_run = false
    it "runs a multi name macro" do
      return if already_run
      already_run = true

      multi_name_macro_invoked = false
      example_group.instance_eval do
        macro "runs a", "multi name", "macro" do
          it "runs" do
            multi_name_macro_invoked = true
          end
        end

        it "runs a", "multi name", "macro"
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))

      multi_name_macro_invoked.should be_true
    end
  end

  describe "Name and variable macro" do
    already_run = false
    it "runs a macro with a name and variable" do
      return if already_run
      already_run = true

      args = []
      example_group.instance_eval do
        macro "runs a macro with a", :name, "and", :variable do |name, variable|
          it "runs" do
            args << name
            args << variable
          end
        end

        it "runs a macro with a", "Jo Momma", "and", :is_phat
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))

      args.should == ["Jo Momma", :is_phat]
    end
  end

  describe "No match" do
    it "raises a MacroNotFoundError" do
      lambda do
        example_group.it("cannot find this macro")
      end.should raise_error(Spec::Macroscopic::MacroNotFoundError)
    end
  end

  def example_group
    self.class
  end
end