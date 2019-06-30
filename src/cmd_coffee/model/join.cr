module CmdCoffee::Model
  class Join
    JSON.mapping(
      access_key: {key: "accessKey", type: String, nilable: false},
    )
  end
end
