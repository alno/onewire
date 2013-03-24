require 'onewire/version'
require 'onewire/client'

module Onewire

  def self.client(*args)
    Client.new(*args)
  end

end
