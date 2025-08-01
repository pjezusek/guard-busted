# frozen_string_literal: true

require 'guard/compat/test/helper'

RSpec.describe Guard::BustedRunner do
  let(:notifier) { instance_double(Guard::BustedNotifier) }
  let(:runner) do
    options = {
      cmd: 'some_command',
      cmd_options: ['--some_option_1', 'some_value_1', '--some_option_2'],
      cmd_all: 'some_command_all',
      cmd_all_options: ['--some_all_option_1', 'some_value_1', '--some_all_option_2']
    }
    described_class.new(options)
  end

  before do
    # disable notification from busted
    allow(Guard::BustedNotifier).to receive(:new).and_return(notifier)
    allow(notifier).to receive(:notify).and_return(true)
  end

  describe '.new' do
    it 'extracts cmd from options' do
      expect(runner.cmd).to eq('some_command')
    end

    it 'extracts cmd_options from options' do
      expect(runner.cmd_options).to eq(['--some_option_1', 'some_value_1', '--some_option_2'])
    end

    it 'extracts cmd_all from options' do
      expect(runner.cmd_all).to eq('some_command_all')
    end

    it 'extracts cmd_all_options from options' do
      expect(runner.cmd_all_options).to eq(['--some_all_option_1', 'some_value_1', '--some_all_option_2'])
    end
  end

  describe '#run_all' do
    context 'when the system command ends with an error' do
      before do
        allow(runner).to receive(:perform_command).and_return([false, 'some_message'])
      end

      it 'throws :task_has_failed' do
        expect { runner.run_all }.to raise_error(StandardError)
      end
    end

    context 'when the system command ends successfully' do
      before do
        allow(Open3).to receive(:popen2e)
      end

      it 'runs a command for all tests' do
        runner.run_all
        expect(Open3).to have_received(:popen2e).with(
          'some_command_all', '--some_all_option_1', 'some_value_1', '--some_all_option_2'
        )
      end
    end
  end

  describe '#run' do
    context 'when there are no test files to run' do
      it 'does not perform command' do
        allow(runner).to receive(:perform_command).and_return([false, 'some_message'])
        runner.run ['path']
        expect(runner).not_to have_received(:perform_command)
      end
    end

    context 'when the system command fails' do
      before do
        allow(runner).to receive(:perform_command).and_return([false, 'some_message'])
      end

      it 'runs a test command for the given paths' do
        expect { runner.run ['spec/fixtures/some_file'] }.to raise_error(StandardError)
      end
    end

    context 'when the system command ends successfully' do
      let(:file_path) { 'spec/fixtures/some_file' }

      before do
        allow(Open3).to receive(:popen2e)
      end

      it 'runs a test command for the given paths' do
        runner.run [file_path, file_path]
        expect(Open3).to have_received(:popen2e).with(
          'some_command', '--some_option_1', 'some_value_1', '--some_option_2', file_path, file_path
        )
      end
    end
  end
end
