require "commander"

module CmdCoffee
  class CLI
    def config_flag
      @config_flag ||= Commander::Flag.new do |flag|
        flag.name = "config"
        flag.short = "-c"
        flag.long = "--config"
        flag.default = "~/.cmd.coffee/config.json"
        flag.description = "config file that drives this client."
      end
    end

    def version_command
      Commander::Command.new do |cmd|
        cmd.use = "version"
        cmd.short = "prints the version and exits"
        cmd.long = cmd.short
        cmd.run do |options, arguments|
          CmdCoffee::Command::Version.new(options, arguments).run
        end
      end
    end

    def init_command
      Commander::Command.new do |cmd|
        cmd.use = "init"
        cmd.short = "launches the configuration walkthrough"
        cmd.long = cmd.short
        cmd.run do |options, arguments|
          CmdCoffee::Command::Init.new(options, arguments).run
        end
      end
    end

    def brew_command
      Commander::Command.new do |cmd|
        cmd.use = "brew <quantity> [units] [with <method>]"
        cmd.short = "utility for determining ratios and grinds"
        cmd.long = CmdCoffee::BREW_LONG
        cmd.flags.add config_flag
        cmd.run do |options, arguments|
          CmdCoffee::Command::Brew.new(options, arguments).run
        end
      end
    end

    def ls_command
      Commander::Command.new do |cmd|
        cmd.use = "ls [order-key]"
        cmd.short = "list your existing orders"
        cmd.long = cmd.short
        cmd.flags.add config_flag
        cmd.run do |options, arguments|
          CmdCoffee::Command::Ls.new(options, arguments).run
        end
      end
    end

    def products_command
      Commander::Command.new do |cmd|
        cmd.use = "products"
        cmd.short = "list available coffees for order"
        cmd.long = cmd.short
        cmd.flags.add config_flag
        cmd.run do |options, arguments|
          CmdCoffee::Command::Products.new(options, arguments).run
        end
      end
    end

    def order_command
      Commander::Command.new do |cmd|
        cmd.use = "order <coffee-code>"
        cmd.short = "order by coffee-code"
        cmd.long = "place an order by coffee-code, result is a crypto currency address to send funds to"
        cmd.flags.add config_flag
        cmd.run do |options, arguments|
          CmdCoffee::Command::Order.new(options, arguments).run
        end
      end
    end

    def config
      Commander::Command.new do |cmd|
        cmd.use = "cmd.coffee"
        cmd.long = "made for developers who drink it"

        # override default help messages
        cmd.commands.commands[0].short = "help about any command"
        cmd.commands.commands[0].long = "help about any command"

        # set global flags
        cmd.flags.add config_flag

        # wire up commands
        cmd.commands.add version_command
        cmd.commands.add init_command
        cmd.commands.add brew_command
        cmd.commands.add products_command
        cmd.commands.add order_command
        cmd.commands.add ls_command

        # wire up help as default cmd
        cmd.run do
          puts cmd.help
        end
      end
    end

    def run(argv)
      Commander.run(config, argv)
    end
  end
end
