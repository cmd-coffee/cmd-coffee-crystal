module CmdCoffee::Model
  class Product
    JSON.mapping(
      code: {key: "code", type: String, nilable: false},
      name: {key: "name", type: String, nilable: false},
      price_usd: {key: "price-usd", type: Float64, nilable: false},
      weight_in_ounces: {key: "weight-in-ounces", type: Float64, nilable: false},
      description: {key: "description", type: String, nilable: true},
      tasting_notes: {key: "tasting-notes", type: String, nilable: true},
    )

    def self.table_header
      ["Code", "Name", "$", "oz", "Description", "Notes"]
    end

    def table_row
      options = {:separator => " "}

      [
        code,
        name.truncate(30, options),
        price_usd,
        weight_in_ounces,
        description.try &.truncate(35, options),
        tasting_notes.try &.truncate(35, options),
      ]
    end
  end
end
