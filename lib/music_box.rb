require 'music_box/stream_player'

module MusicBox
  module_function

  def play(filename)
    track = File.open(filename)
    StreamPlayer.new(track).play
  end
end
