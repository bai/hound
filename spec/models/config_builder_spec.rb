require "spec_helper"
require "app/models/config_builder"
require "app/models/config/base"
require "app/models/config/ruby"
require "app/models/config/unsupported"
require "app/models/missing_owner"

describe ConfigBuilder do
  describe ".for" do
    context "when there is matching config class for the given name" do
      it "returns the matching config" do
        config = ConfigBuilder.for(
          hound_config: double,
          name: "ruby",
          owner: instance_double("Owner"),
        )

        expect(config).to be_a(Config::Ruby)
      end
    end

    context "when there is not matching config class for the given name" do
      it "returns the unsupported config" do
        config = ConfigBuilder.for(
          hound_config: double,
          name: "non-existent-config",
          owner: instance_double("Owner"),
        )

        expect(config).to be_a(Config::Unsupported)
      end
    end
  end
end
