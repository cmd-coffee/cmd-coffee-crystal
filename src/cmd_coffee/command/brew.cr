module CmdCoffee::Command
  class Brew
    AVAILABLE_UNITS   = ["mug", "mugs", "oz", "ounces", "g", "grams"]
    AVAILABLE_METHODS = ["drip", "chemex", "frenchpress", "golden"]

    QUANTITY_REGEX = /(?<quantity>([0-9]*[.])?[0-9]+)/
    UNITS_REGEX    = /(?<unit>#{AVAILABLE_UNITS.join("|")})/
    METHODS_REGEX  = /(?<method>#{AVAILABLE_METHODS.join("|")})/
    FULL_REGEX     = /^#{QUANTITY_REGEX}(\s#{UNITS_REGEX})?(\swith\s#{METHODS_REGEX})?$/

    WATER_LOSS_RATE =     1.05
    GRAMS_TO_OZ     =  0.03381
    OZ_TO_GRAMS     = 29.57353
    MUGS_TO_GRAMS   = 11.0 * OZ_TO_GRAMS

    UNIT_STANDARDIZATIONS = {
      "mug"    => MUGS_TO_GRAMS,
      "mugs"   => MUGS_TO_GRAMS,
      "oz"     => OZ_TO_GRAMS,
      "ounces" => OZ_TO_GRAMS,
      "g"      => 1.0,
      "grams"  => 1.0,
    }

    BREW_RATIOS = {
      "drip"        => 0.06,
      "chemex"      => 0.06285714,
      "frenchpress" => 0.0625,
      "golden"      => 0.06,
    }

    GRINDS = {
      "drip"        => "drip",
      "chemex"      => "electric perk",
      "frenchpress" => "coarse",
      "golden"      => "drip",
    }

    property quantity : Float64 | Nil
    property unit : String | Nil
    property method : String | Nil

    def initialize(options, @arguments : Array(String))
      config_absolute_path = Path.new(options.string["config"]).expand
      @config = CmdCoffee::Model::Config.from_json File.new(config_absolute_path)
    end

    private def parse(arguments)
      FULL_REGEX.match(arguments.join(" "))
    end

    private def failed(message)
      puts message
      CmdCoffee::EXIT_CODE_FAILURE
    end

    def run
      m = parse(@arguments)
      return failed("unable to parse the arguments '#{@arguments}'") unless m

      @quantity = (m.try &.["quantity"]? || 1.0).to_f
      @unit = m.try &.["unit"]? || "mugs"
      @method = m.try &.["method"]? || "drip"

      water_amount_grams = @quantity.as(Float64) * UNIT_STANDARDIZATIONS[@unit] * WATER_LOSS_RATE
      coffee_amount_grams = BREW_RATIOS[@method] * water_amount_grams
      grind = GRINDS[@method]

      message = <<-MESSAGE
        Quantity: #{@quantity}
        Unit: #{@unit}
        Method: #{method}

        Water: #{water_amount_grams.format(decimal_places: 2)}g
        Coffee: #{coffee_amount_grams.format(decimal_places: 2)}g
        Grind: #{grind}
      MESSAGE

      puts message
      CmdCoffee::EXIT_CODE_SUCCESS
    end
  end
end
