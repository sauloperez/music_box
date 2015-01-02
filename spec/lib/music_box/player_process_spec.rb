require 'spec_helper'

describe MusicBox::PlayerProcess do
  describe '#initialize' do
    let(:process_name) { 'mpg123' }
    let(:process) {
      `ps -o comm`.split("\n")
        .find { |cmd| cmd == process_name }
    }

    it 'opens a mpg123 process' do
      MusicBox::PlayerProcess.new
      expect(process).to be
    end
  end

  describe '#kill' do
    let(:signal) { 'TERM' }
    let(:pid) { subject.send(:pid) }

    it 'sends the provided signal to the player process' do
      expect(Process).to receive(:kill).with(signal, pid)
      subject.kill(signal)
    end
  end

  describe '#play' do
    let(:data) { 'random data' }
    let(:stdin) { double(IO) }

    before { allow(subject).to receive(:stdin).and_return(stdin) }

    it 'passes it to the process STDIN' do
      expect(stdin).to receive(:puts).with(data)
      subject.play(data)
    end
  end
end
