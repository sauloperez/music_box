require 'open3'

module MusicBox
  class PlayerProcess
    def initialize
      @stdin, @stdout, @stderr, @wait_thread = Open3.popen3('mpg123', '-')
      @pid = @wait_thread[:pid]
    end

    def kill(signal)
      Process.kill(signal, pid)
    end

    def play(data)
      puts 'Playing...'
      stdin.puts data
      puts 'Done!'
    end

    private

    attr_reader :pid, :stdin
  end
end
