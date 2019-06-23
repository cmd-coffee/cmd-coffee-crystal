module CmdCoffee::Model
  class Config
    JSON.mapping(
      requestor_id: {key: "requestor_id", type: UUID, nilable: false},
      access_key: {key: "access_key", type: String, nilable: false},
      shipping_address: {key: "shipping-address", type: ShippingAddress, nilable: false},
    )

    def initialize(_requestor_id, _access_key, _shipping_address)
      @requestor_id = _requestor_id
      @access_key = _access_key
      @shipping_address = _shipping_address
    end

    def save(path)
      FileUtils.mkdir_p(path.dirname, 0o700)
      File.write(path, to_pretty_json, mode: "w", perm: 0o600)
    end
  end
end
