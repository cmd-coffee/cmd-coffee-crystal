module CmdCoffee::Model
  class Order
    JSON.mapping(
      order_key: {key: "orderKey", type: String, nilable: true},
      status: {key: "status", type: String, nilable: true},
      product_code: {key: "productCode", type: String, nilable: false},
      product_name: {key: "productName", type: String, nilable: true},
      promo_code: {key: "promoCode", type: String, nilable: true},

      sub_total: {key: "subTotal", type: Float64, nilable: true},
      discount: {key: "discount", type: Float64, nilable: true},
      total: {key: "total", type: Float64, nilable: true},

      shipping_address: {key: "shippingAddress", type: ShippingAddress, nilable: false},

      order_history: {key: "orderHistory", type: Array(String), nilable: true},

      date_created: {key: "dateCreated", type: Time, nilable: true},
      status_updated: {key: "statusUpdated", type: Time, nilable: true},
    )

    def self.table_header
      ["Order Key", "Status", "Product Code", "Product Name", "Sub Total", "Discount", "Total", "Shipping", "Created"]
    end

    def initialize(_product_code, _shipping_address, _promo_code = nil)
      @product_code = _product_code
      @shipping_address = _shipping_address
      @promo_code = _promo_code
    end

    def table_row
      [
        order_key,
        status,
        product_code,
        product_name,
        sub_total,
        discount,
        total,
        shipping_address.to_s,
        date_created.try &.to_s,
      ]
    end
  end
end
