require 'music_box/stream_player'

class Runner
  def self.run(track)
    set_traps

    @player = StreamPlayer.new(track)
    @player.play
  end

  private

  def self.set_traps
    trap('INT') { shutdown }
  end

  def self.shutdown
    puts 'Stoping...'
    @player.stop
  end
end
