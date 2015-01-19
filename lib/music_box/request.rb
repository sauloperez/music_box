module MusicBox
  class Request

    attr_reader :command, :body

    def initialize(payload)
      raise Error unless payload.size > 0

      @command = payload.match(COMMAND)[0]
      @body = payload.slice(@command.length, payload.length - @command.length)
    end

    def process
      case command.upcase
      when 'PLAY'
        play
      when 'STOP'
        stop
      end
    end

    private

    COMMAND = /^\w+/

    def play
      @player ||= PlayerProcess.new
      @player.play(body)
    end

    def stop
      return unless @player
      @player.kill('TERM')
    end

  end
end
