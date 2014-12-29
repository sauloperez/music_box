#!/usr/bin/env ruby

require 'byebug'
require 'open3'

class StreamPlayer
  def initialize(file)
    @file = file
  end

  def play
    spawn_player do |stdin, stdout, stderr|
      basename = File.basename(@file.path)
      puts "Playing #{basename}..."

      stdin.puts @file.read
      stdin.close

      while output = stdout.read do
        puts output
      end
    end
  end

  private

  def spawn_player
    Open3.popen3('mpg123', '-') do |stdin, stdout, stderr|
      yield stdin, stdout, stderr
    end
  end
end

filename = ARGV[0]

track = File.open(filename)
Player.new(track).play
