require 'socket'

module MusicBox
  class StreamPlayer
    PORT = 4481

    def initialize
      @player = PlayerProcess.new
      @server = Socket.new(:INET, :STREAM)
      @addr = Socket.pack_sockaddr_in(PORT, '0.0.0.0')

      server_loop do |connection|
        play(connection)
      end
    end

    def play(file)
      @player.play file.read
    rescue Errno::EPIPE
    end

    def stop
      @player.kill('TERM')
      puts 'Bye'
    end

    private

    def server_loop
      @server.bind(@addr)
      @server.listen(Socket::SOMAXCONN)

      loop do
        puts 'Waiting for connection...'

        connection, _ = @server.accept
        connection.close_write
        yield connection
        connection.close
      end
    end
  end
end
