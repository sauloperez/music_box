module MusicBox
  class Runner
    def self.start
      new
    end

    def initialize
      set_traps

      @player = StreamPlayer.new
      @player.play
    end

    private

    def set_traps
      trap('INT') { shutdown }
    end

    def shutdown
      puts 'Stoping...'
      @player.stop if @player
      exit
    end
  end
end
