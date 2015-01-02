require 'music_box/runner'
require 'music_box/stream_player_server'
require 'music_box/player_process'

module MusicBox
  def self.start
    Runner.start
  end
end
