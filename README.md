# cmd-coffee-crystal

A cmd line client written in crystal for interacting with [cmd.coffee](https://cmd.coffee/).

<img src="jessica-lewis-1509526-unsplash.jpg" alt="Photo by Jessica Lewis on Unsplash" width="100%" />

## Project Health Status

[![CircleCI](https://circleci.com/gh/cmd-coffee/cmd-coffee-crystal.svg?style=shield)](https://circleci.com/gh/cmd-coffee/cmd-coffee-crystal)

## Getting Started

> Right now the only way to install this client is by building from source. You'll need to have [crystal](https://crystal-lang.org/) installed to do so.

```sh
> git clone git@github.com:cmd-coffee/cmd-coffee-crystal.git
> cd cmd-coffee-crystal
> shards install
> crystal build --warnings all -o bin/cmd.coffee ./src/main.cr
```

### Usage



```sh
> ./bin/cmd.coffee init

# ... go through the init process to get started ...

> ./bin/cmd.coffee help

  cmd.coffee - made for developers who drink it

  Usage:
    cmd.coffee [command] [flags] [arguments]

  Commands:
    brew <quantity> [units] [with <method>]  # utility for determining ratios and grinds
    help [command]                           # help about any command
    init                                     # launches the configuration walkthrough
    ls [order-key]                           # list your existing orders
    order <coffee-code>                      # order by coffee-code
    products                                 # list available coffees for order
    version                                  # prints the version and exits

  Flags:
    -c, --config  # config file that drives this client. default: '~/.cmd.coffee/config.json'.
    -h, --help    # Help for this command. default: 'false'.
```

## Contributing

1. Fork it (<https://github.com/your-github-user/cmd-coffee-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
