module CmdCoffee::Command
  class Version
    def initialize(options, @arguments : Array(String))
    end

    def run
      puts get
      CmdCoffee::EXIT_CODE_SUCCESS
    end

    def get
      CmdCoffee::VERSION
    end
  end
end
