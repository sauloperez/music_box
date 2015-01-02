module MusicBox
  class Runner
    def self.start
      new
    end

    def initialize
      set_traps
      @server = StreamPlayerServer.new
      @server.start
    end

    def shutdown
      puts 'Stoping...'
      @server.stop if @server
      exit
    end

    private

    def set_traps
      trap('INT') { shutdown }
    end
  end
end
