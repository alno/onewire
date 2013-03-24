# Onewire

It's simple Ruby client for OWFS [owserver](http://owfs.org/index.php?page=owserver_protocol)

## Installation

Add this line to your application's Gemfile:

    gem 'onewire'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install onewire

## Basic usage

Create client like:

    require 'onewire'
    client = Onewire.client

You may specify optional host/port like this:

    Onewire.client 'localhost', 4304

Then, you may list OWFS directories:

    client.dir('/')
    => ["/10.67C6697351FF", "/05.4AEC29CDBAAB", "/bus.0", "/uncached", "/settings", "/system", "/statistics", "/structure", "/simultaneous", "/alarm"]

And read values:

    client.read('/10.67C6697351FF/temperature')
    => 24.2887

Or even write them:

    client.write('/10.67C6697351FF/alias','somealias')
    => nil
    c.read('/10.67C6697351FF/alias')
    => "somealias"

## Scopes

To simplify some operations _scopes_ are available. Scopes provide client-like interface, but where all path arguments are relative to some node. For example:

    scope = client.scope('/10.67C6697351FF')
    scope.read('temperature')
    => 24.2887

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
