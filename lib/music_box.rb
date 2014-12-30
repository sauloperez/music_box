require 'music_box/runner'

module MusicBox
  def self.play(filename)
    track = File.open(filename)
    Runner.run(track)
  end
end
