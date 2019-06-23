module CmdCoffee::Command
  class Init
    def initialize(options, @arguments : Array(String))
    end

    private def get_data(label)
      print "#{label}: "
      gets.not_nil!
    end

    private def get_access_key
      code = get_data("Enter Invitation Code")
      client = CmdCoffee::API::Client.new(CmdCoffee::API_URL)
      client.join(code).access_key
    end

    private def get_shipping_address
      puts
      puts "Kindly enter your shipping details to use when ordering (saved locally)."
      puts

      CmdCoffee::Model::ShippingAddress.new(
        get_data("Name"),
        get_data("Company"),
        get_data("Shipping Address 1"),
        get_data("Shipping Address 2"),
        get_data("City"),
        get_data("State"),
        get_data("Zip"),
        get_data("Email"),
        get_data("Phone")
      )
    end

    def run
      puts
      puts CmdCoffee::ASCII_BANNER
      puts

      config_path = Path.home / ".cmd.coffee" / "config.json"

      if File.exists?(config_path)
        puts "the config file '#{config_path}' already exists"
        return CmdCoffee::EXIT_CODE_FAILURE
      end

      access_key = get_access_key
      shipping_address = get_shipping_address

      puts shipping_address.to_json

      config = CmdCoffee::Model::Config.new(UUID.random, access_key, shipping_address)
      config.save(config_path)

      puts "Configuration saved to: #{config_path}"
      CmdCoffee::EXIT_CODE_SUCCESS
    end
  end
end
