require 'spec_helper'
require_relative '../../lib/24'

describe RosettaCode24 do
  subject { described_class }

  describe '#new' do
    it 'returns a rosetta code 24 object' do
      expect(subject.new).to be_an_instance_of(RosettaCode24)
    end
  end

  describe '#run' do
    subject { described_class.new }
    let(:numbers) { [1, 2, 3, 4] }
    before(:each) do
      allow($stdin).to receive(:gets).and_return(numbers.join("+") + "\n")
    end

    it 'prints four random numbers between 1-9 to stdout' do
      expect{ subject.run }.to output(/[1-9], [1-9], [1-9], [1-9]/).to_stdout
    end

    it 'prompts the user for input' do
      expect { subject.run }.to output(/Please enter an equation/).to_stdout
    end

    it 'outputs the total' do
      subject.numbers = numbers
      expect { subject.run }.to output(/Total: #{numbers.inject(0, :+)}/).to_stdout
    end
  end
end
