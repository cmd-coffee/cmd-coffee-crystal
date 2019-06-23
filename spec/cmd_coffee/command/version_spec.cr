require "../../spec_helper"

describe CmdCoffee::Command::Version do
  describe ".new" do
    it "instantiates" do
      options = Commander::Options.new
      arguments = [] of String

      cmd = CmdCoffee::Command::Version.new(options, arguments)
      cmd.should_not be_nil
    end
  end

  describe "#get" do
    it "returns the current version" do
      options = Commander::Options.new
      arguments = [] of String

      cmd = CmdCoffee::Command::Version.new(options, arguments)
      cmd.get.should eq CmdCoffee::VERSION
    end
  end
end
