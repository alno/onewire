require 'onewire/connection'

module Onewire
  class Scope

    DELEGATED_METHODS = %q{dir read write scope}

    def initialize(client, path)
      @client, @path = client, path
    end

    def method_missing(name, *args, &block)
      if DELEGATED_METHODS.include? name.to_s
        path = "#{@path}/#{args.shift}" # Update path

        @client.send name, path, *args, &block
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      DELEGATED_METHODS.include? name.to_s
    end

  end
end
