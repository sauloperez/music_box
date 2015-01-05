require 'byebug'
require 'socket'

module MusicBox
  class Server
    PORT = 4481

    def initialize(port = PORT)
      @server = TCPServer.new(port)
      puts "Listening on port #{@server.local_address.ip_port}..."
    end

    def start
      Socket.accept_loop(server) do |connection|
        handle(connection)
        connection.close
      end
    end

    private

    EXIT = 'EXIT'
    SIZE_OF_INT = [11].pack('i').size

    attr_reader :server

    def handle(connection)
      loop do
        msg_length = get_content_length(connection)
        payload = connection.read(msg_length)
        request = Request.new(payload)
        break if request.command.upcase == EXIT

        request.process
      end
    end

    def get_content_length(connection)
      packed_msg_length = connection.read(SIZE_OF_INT)
      packed_msg_length.unpack('i').first
    end
  end
end
