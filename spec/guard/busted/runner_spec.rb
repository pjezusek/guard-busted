# frozen_string_literal: true

require 'guard/compat/test/helper'

RSpec.describe Guard::BustedRunner do
  let(:runner) do
    options = {
      cmd: 'some_command',
      cmd_options: 'some_options',
      cmd_all: 'some_command_all',
      cmd_all_options: 'some_command_all_options'
    }
    Guard::BustedRunner.new(options)
  end

  describe '.new' do
    it 'extracts data from options' do
      expect(
        [runner.cmd, runner.cmd_options, runner.cmd_all, runner.cmd_all_options]
      ).to eq(
        %w[some_command some_options some_command_all some_command_all_options]
      )
    end
  end

  describe '#run_all' do
    context 'when the system command ends with an error' do
      before do
        allow(runner).to receive(:system).and_return(false)
      end

      it 'should throw :task_has_failed' do
        expect { runner.run_all }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      before do
        allow(runner).to receive(:system).and_return(true)
      end

      context 'when options are provided as a string' do
        it 'runs a command for all tests' do
          runner.run_all
          expect(runner).to have_received(:system).with(
            'some_command_all some_command_all_options'
          )
        end
      end

      context 'when options are provided as an array' do
        before do
          runner.cmd_all_options = ['--first_option', '--second_option']
        end

        it 'runs a command for all tests' do
          runner.run_all
          expect(runner).to have_received(:system).with(
            'some_command_all --first_option --second_option'
          )
        end
      end
    end
  end

  describe '#run' do
    context 'when the system command ends with an error' do
      before do
        allow(runner).to receive(:system).and_return(false)
      end

      it 'runs a test command for the given paths' do
        expect { runner.run['path'] }.to raise_error
      end
    end

    context 'when the system command ends successfully' do
      let(:file_path) { 'spec/fixtures/some_file' }

      before do
        allow(runner).to receive(:system).and_return(true)
      end

      context 'when options are provided as an array' do
        it 'runs a test command for the given paths' do
          runner.run([file_path])
          expect(runner).to have_received(:system).with(
            "some_command some_options #{file_path}"
          )
        end
      end

      context 'when options are provided as an array' do
        before do
          runner.cmd_options = ['--first_option', '--second_option']
        end

        it 'runs a test command for the given paths' do
          runner.run([file_path])
          expect(runner).to have_received(:system).with(
            "some_command --first_option --second_option #{file_path}"
          )
        end
      end
    end
  end
end
