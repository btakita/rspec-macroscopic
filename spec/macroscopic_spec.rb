require "#{File.dirname(__FILE__)}/spec_helper"

describe "Macrscopic Rspec" do
  describe "Single name macro" do
    it "runs a single name macro" do
      single_name_macro_invoked = false
      example_group = Spec::Example::ExampleGroup.describe("") do
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
    it "runs a multi name macro" do
      multi_name_macro_invoked = false
      example_group = Spec::Example::ExampleGroup.describe("") do
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
    it "runs a macro with a name and variable" do
      args = []
      example_group = Spec::Example::ExampleGroup.describe("") do
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

  describe "Instance evaluation context" do
    it "runs in the context of its ExampleGroup" do
      macro_self = false
      example_group = Spec::Example::ExampleGroup.describe("") do
        macro "respects self" do
          macro_self = self
        end
        it "respects self"
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))

      macro_self.should == example_group
    end
  end

  describe "Inheritance" do
    it "runs macros from superclasses" do
      top_level_called = false
      child_example_group = nil
      Spec::Example::ExampleGroup.describe("") do
        macro "runs from the top level" do
          it "runs from the top level" do
            top_level_called = true
          end
        end

        child_example_group = describe "nested ExampleGroup" do
          it "runs from the top level"
        end
      end

      err, output = StringIO.new, StringIO.new
      child_example_group.run(Spec::Runner::Options.new(err, output))

      top_level_called.should be_true
    end

    it "allows subclasses to override macros" do
      overridden_called = false
      example_group = nil
      Spec::Example::ExampleGroup.describe("") do
        macro "can be overridden" do
          it "can be overridden" do
          end
        end

        example_group = describe "nested ExampleGroup" do
          macro "can be overridden" do
            it "overrides" do
              overridden_called = true
            end
          end

          it "can be overridden"
        end
      end

      err, output = StringIO.new, StringIO.new
      example_group.run(Spec::Runner::Options.new(err, output))

      overridden_called.should be_true
    end

    it "runs in the context of the calling ExampleGroup" do
      child_example_group = nil
      macro_self = nil
      Spec::Example::ExampleGroup.describe("") do
        macro "runs from the top level" do
          macro_self = self
        end

        child_example_group = describe "nested ExampleGroup" do
          it "runs from the top level"
        end
      end

      err, output = StringIO.new, StringIO.new
      child_example_group.run(Spec::Runner::Options.new(err, output))
      macro_self.should == child_example_group
    end
  end

  describe "No match" do
    it "raises a MacroNotFoundError" do
      example_group = Spec::Example::ExampleGroup.describe("") do
      end

      lambda do
        example_group.it("cannot find this macro")
      end.should raise_error(Spec::Macroscopic::MacroNotFoundError)
    end
  end
end