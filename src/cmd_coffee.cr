# TODO: Write documentation for `CmdCoffee`
module CmdCoffee
  VERSION = "0.1.0"

  ASCII_BANNER = <<-BANNER
********************************************************************************
*                                                                              *
*                               > cmd.coffee                                   *
*                                                                              *
********************************************************************************
BANNER

  API_URL = "https://api.cmd.coffee"

  BREW_LONG = "utility for determining ratios and grinds\n" \
              "\n" \
              "  Example:\n" \
              "    brew 4 mugs with french-press\n" \
              "\n" \
              "    brew <quantity> [units] [with <method>]\n" \
              "\n" \
              "    quantity: the number of 'units' to brew\n" \
              "\n" \
              "    units:    the brewing unit (default 'mugs')\n" \
              "              mugs|oz|ounces|g|grams\n" \
              "\n" \
              "    method:   the brewing technique to use (default 'drip')\n" \
              "              drip|chemex|frenchpress|espresso|golden"

  EXIT_CODE_SUCCESS = 0
  EXIT_CODE_FAILURE = 1
end
