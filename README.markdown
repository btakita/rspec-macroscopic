# Rspec Macroscopic

This library alters rspec, making it easier to use and create more expressive macros.

Specifically, the it method, when not passed a block, is co-opted to call a macro, defined using macro.

Got it? Ok, well, here is an example.

    describe "Something cool" do
      macro "allows", :person, "to see", :object do |person_callback, object_callback|
        describe ":person" do
          it "can see anything" do
            person_callback.call.can_see?.should be_true
          end

          it "can see the object" do
            person_callback.call.can_see?(object_callback.call).should be_true
          end
        end
      end
    end