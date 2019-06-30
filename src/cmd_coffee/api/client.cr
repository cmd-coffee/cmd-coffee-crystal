module CmdCoffee::API
  class Client
    def initialize(@api_url : String)
      @access_key = nil
    end

    def initialize(@api_url : String, @access_key : String)
    end

    def headers
      h = HTTP::Headers.new
      h["User-Agent"] = "> cmd.coffee client (crystal)"
      h["Content-Type"] = "application/json"
      @access_key.try { |ak| h["X-Access-Key"] = ak }
      h
    end

    def full_url(path)
      "#{@api_url}/#{path}"
    end

    private def raise_if_failed(response)
      return if response.success?
      raise "Request Failed [#{response.status_code}]: #{response.to_s}"
    end

    def order(ord)
      url = full_url("orders")
      response = HTTP::Client.post(url, headers, ord.to_json)

      raise_if_failed(response)

      response.body
    end

    def orders
      url = full_url("orders")
      response = HTTP::Client.get(url, headers)

      raise_if_failed(response)

      Array(CmdCoffee::Model::Order).from_json(response.body)
    end

    def orders(key)
      url = full_url("orders/#{key}")
      response = HTTP::Client.get(url, headers)

      raise_if_failed(response)

      [CmdCoffee::Model::Order.from_json(response.body)]
    end

    def join(invite_code)
      request_json = JSON.build do |json|
        json.object do
          json.field "inviteCode", invite_code
        end
      end

      url = full_url("join")
      response = HTTP::Client.post(url, headers, request_json)

      raise_if_failed(response)

      CmdCoffee::Model::Join.from_json(response.body)
    end

    def products
      url = full_url("products")
      response = HTTP::Client.get(url, headers)

      raise_if_failed(response)

      Array(CmdCoffee::Model::Product).from_json(response.body)
    end
  end
end
