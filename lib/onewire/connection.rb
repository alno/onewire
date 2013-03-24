require 'socket'

module Onewire
  class Connection

    PING = 4294967295 # -1 as unsigned int

    def initialize(host = 'localhost', port = 4304)
      @socket = TCPSocket.new host, port
    end

    def close
      @socket.close
    end

    def write(type, payload, size = 0, offset = 0)
      request_fields = [version, payload.size, type, flags, size, offset, payload] # Prepare request structure (see http://owfs.org/index.php?page=owserver-protocol)
      request_data = request_fields.pack('NNNNNNA*') # Pack it - first six parts are integers, payload is string

      @socket.write request_data # Send it
    end

    def read
      _, payload_size, _, _, size, offset = read_header

      if payload_size > 0
        @socket.read(payload_size)[offset..offset+size-1] # Read response payload
      else
        nil
      end
    end

    def read_header
      loop do
        header = @socket.read(24).unpack('NNNNNN') # Read and unpack response header (see http://owfs.org/index.php?page=owserver-protocol)
        return header if header[1] != PING # Return when non-ping response read
      end
    end

    def flags
      258 # TODO
    end

    def version
      0
    end

  end

end
