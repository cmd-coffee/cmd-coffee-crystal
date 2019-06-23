module CmdCoffee::Model
  class Join
    JSON.mapping(
      access_key: {key: "access-key", type: String, nilable: false},
    )
  end
end
