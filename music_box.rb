#!/usr/bin/env ruby

require 'open3'

filename = ARGV[0]

Open3.popen3('mpg123', '-') do |stdin, stdout, stderr|
  puts "Playing #{filename}..."

  stdin.puts File.open(filename).read
  stdin.close

  while output = stdout.read do
    puts output
  end
end
