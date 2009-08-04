# Rspec Macroscopic

This library alters rspec, making it easier to use and create more expressive macros.

Specifically, the it method, when not passed a block, is co-opted to call a macro, defined using macro.

Got it? Ok, well, here is an example.

    describe "Something cool" do
      macro "allows", :person, "to see", :object do |person, object|
        describe ":person" do
          it "can see" do
            person.can_see?.should be_true
          end
        end
      end
    end