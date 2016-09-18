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
    let(:numbers) { [1, 2, 3, 4] }
    subject { described_class.new }

    before(:each) do
      subject.numbers = numbers
      allow($stdin).to receive(:gets).and_return(numbers.join("+") + "\n")
    end

    it 'prints four random numbers between 1-9 to stdout' do
      expect{ subject.run }.to output(/[1-9], [1-9], [1-9], [1-9]/).to_stdout
    end

    it 'prompts the user for input' do
      expect { subject.run }.to output(/Please enter an equation/).to_stdout
    end

    it 'outputs the total' do
      expect { subject.run }.to output(/Total: #{numbers.inject(0, :+)}/).to_stdout
    end

    context 'the user enters an equation without using each random number' do
      let(:missing_number_equation) { "1 + 2 + 5 + 4\n" }
      before do
        # Mask stdout, we are only looking for errors in this context
        @original_stdout = $stdout
        $stdout = File.open(File::NULL, 'w')
        subject.numbers = numbers
        allow($stdin).to receive(:gets).and_return(missing_number_equation)
      end

      after do
        $stdout = @original_stdout
      end

      it 'exits' do
        expect { subject.run }.to output("Error: Invalid equation, you must use each number once.\n").to_stderr
      end
    end
  end
end
