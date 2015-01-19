require 'music_box/runner'
require 'music_box/server'
require 'music_box/request'
require 'music_box/player_process'
require 'music_box/error'

module MusicBox
  def self.start
    Runner.start
  end
end
