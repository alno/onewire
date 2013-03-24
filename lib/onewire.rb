require 'onewire/version'
require 'onewire/client'

module Onewire

  def client(*args)
    Client.new(*args)
  end

end
