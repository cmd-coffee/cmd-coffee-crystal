module CmdCoffee::Command
  class Order
    def initialize(options, @arguments : Array(String))
      config_absolute_path = Path.new(options.string["config"]).expand
      @config = CmdCoffee::Model::Config.from_json File.new(config_absolute_path)
    end

    private def parse(arguments)
      r = /^(?<code>[0-9A-Z]+)$/i
      r.match(arguments.join(" "))
    end

    private def failed(message)
      puts message
      CmdCoffee::EXIT_CODE_FAILURE
    end

    def run
      m = parse(@arguments)
      return failed("unable to parse the arguments '#{@arguments}'") unless m

      order = CmdCoffee::Model::Order.new(m["code"], @config.shipping_address)
      client = CmdCoffee::API::Client.new(CmdCoffee::API_URL, @config.access_key)

      result = client.order(order)
      puts result
      CmdCoffee::EXIT_CODE_SUCCESS
    end
  end
end
