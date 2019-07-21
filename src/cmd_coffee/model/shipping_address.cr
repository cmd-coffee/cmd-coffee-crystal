module CmdCoffee::Model
  class ShippingAddress
    JSON.mapping(
      name: {key: "name", type: String, nilable: false},
      company: {key: "company", type: String, nilable: true},
      address1: {key: "address1", type: String, nilable: false},
      address2: {key: "address2", type: String, nilable: true},
      city: {key: "city", type: String, nilable: false},
      state: {key: "state", type: String, nilable: false},
      zip: {key: "zip", type: String, nilable: false},
      email: {key: "email", type: String, nilable: true},
      phone: {key: "phone", type: String, nilable: true},
    )

    def initialize(_name, _company, _address1, _address2, _city, _state, _zip, _email, _phone)
      @name = _name
      @company = _company.blank? ? nil : _company
      @address1 = _address1
      @address2 = _address2.blank? ? nil : _address2
      @city = _city
      @state = _state
      @zip = _zip
      @email = _email.blank? ? nil : _email
      @phone = _phone.blank? ? nil : _phone
    end

    def to_s
      [
        @name,
        @company.try &.blank? ? nil : @company,
        @address1,
        @address2.try &.blank? ? nil : @address2,
        @city,
        @state,
        @zip,
        @email.try &.blank? ? nil : @email,
        @phone.try &.blank? ? nil : @phone
      ].compact!.join(", ")
    end
  end
end
