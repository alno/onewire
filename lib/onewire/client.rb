require 'onewire/connection'
require 'onewire/scope'

module Onewire
  class Client

    class Error < StandardError; end

    ERROR = 0
    NOP = 1
    READ = 2
    WRITE = 3
    DIR = 4
    SIZE = 5
    PRESENCE = 6

    def initialize(host = 'localhost', port = 4304)
      @host, @port = host, port
    end

    def dir(path = '')
      interact do |c|
        c.write DIR, "#{normalize path}\0", 8192

        res = []

        while dir = c.read
          res << dir
        end

        res
      end
    end

    def read(path)
      interact do |c|
        c.write READ, "#{normalize path}\0", 8192 # Default value size to read
        typecast c.read
      end
    end

    def scope(path = '')
      Onewire::Scope.new self, path
    end

    private

    def normalize(path)
      path.gsub(/\A(?!\/)|\/{2,}/,'/')
    end

    def typecast(val)
      Float(val) rescue val
    end

    def interact
      conn = Connection.new(@host, @port)

      begin
        yield conn
      ensure
        conn.close
      end
    end

  end
end
