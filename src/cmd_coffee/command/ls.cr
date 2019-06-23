module CmdCoffee::Command
  class Ls
    def initialize(options, @arguments : Array(String))
      config_absolute_path = Path.new(options.string["config"]).expand
      @config = CmdCoffee::Model::Config.from_json File.new(config_absolute_path)
    end

    private def parse(arguments)
      r = /^(?<key>[0-9A-F]{8}[-]?(?:[0-9A-F]{4}[-]?){3}[0-9A-F]{12})$/i
      r.match(arguments.join(" "))
    end

    private def client
      CmdCoffee::API::Client.new(CmdCoffee::API_URL, @config.access_key)
    end

    private def ls
      client.orders
    end

    private def ls(key)
      client.orders(key)
    end

    private def render(orders : Array(CmdCoffee::Model::Order))
      table = TerminalTable.new
      table.headings = CmdCoffee::Model::Order.table_header
      orders.each { |order| table << order.table_row }

      puts
      puts table.render

      CmdCoffee::EXIT_CODE_SUCCESS
    end

    private def failed(message)
      puts message
      CmdCoffee::EXIT_CODE_FAILURE
    end

    def run
      return render(ls) if @arguments.empty?

      m = parse(@arguments)
      return failed("unable to parse the arguments '#{@arguments}'") unless m

      render(ls(m["key"]))
    end
  end
end
