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

    def handle(connection)
      # TODO: watch out for buffer's memory alloaction
      data = connection.read
      command = data.match(COMMAND)[0]

      case command.upcase
      when 'PLAY'
        play(data)
      when 'STOP'
        stop
      end
    end

    def play(data)
      @player ||= PlayerProcess.new
      @player.play(data)
    end

    def stop
      @player.kill('TERM')
    end

    private

    COMMAND = /^\w+/

    attr_reader :server
  end
end
