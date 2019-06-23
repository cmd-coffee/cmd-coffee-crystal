module CmdCoffee::Model
  class Order
    JSON.mapping(
      order_key: {key: "order-key", type: String, nilable: true},
      state: {key: "state", type: String, nilable: true},
      product_code: {key: "product-code", type: String, nilable: false},
      product_name: {key: "product-name", type: String, nilable: true},
      shipping_address: {key: "shipping-address", type: ShippingAddress, nilable: false},
    )

    def self.table_header
      ["Order Key", "State", "Product Code", "Product Name", "Shipping"]
    end

    def initialize(_product_code, _shipping_address)
      @product_code = _product_code
      @shipping_address = _shipping_address
    end

    def table_row
      [
        order_key,
        state,
        product_code,
        product_name,
        shipping_address.to_s,
      ]
    end
  end
end
