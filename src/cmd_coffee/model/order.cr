module CmdCoffee::Model
  class Order
    JSON.mapping(
      order_key: {key: "orderKey", type: String, nilable: true},
      status: {key: "status", type: String, nilable: true},
      product_code: {key: "productCode", type: String, nilable: false},
      product_name: {key: "productName", type: String, nilable: true},
      shipping_address: {key: "shippingAddress", type: ShippingAddress, nilable: false},
    )

    def self.table_header
      ["Order Key", "Status", "Product Code", "Product Name", "Shipping"]
    end

    def initialize(_product_code, _shipping_address)
      @product_code = _product_code
      @shipping_address = _shipping_address
    end

    def table_row
      [
        order_key,
        status,
        product_code,
        product_name,
        shipping_address.to_s,
      ]
    end
  end
end
