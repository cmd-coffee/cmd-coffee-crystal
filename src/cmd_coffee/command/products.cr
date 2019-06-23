module CmdCoffee::Command
  class Products
    def initialize(options, @arguments : Array(String))
    end

    def run
      client = CmdCoffee::API::Client.new(CmdCoffee::API_URL)
      products = client.products

      table = TerminalTable.new
      table.headings = CmdCoffee::Model::Product.table_header
      products.each { |product| table << product.table_row }

      puts
      puts table.render
    end
  end
end
