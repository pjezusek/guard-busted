# frozen_string_literal: true

RSpec.describe Guard::BustedNotifier do
  let(:notifier) { described_class }

  describe '#notify' do
    context 'when using utfTerminal as an output' do
      context 'when status is false' do
        let(:message) { File.read('spec/fixtures/summary_success_utfTerminal') }

        it 'sends notifcation with success' do
          allow(Guard::Notifier).to receive(:notify)
          notifier.new(message, true).notify
          expect(Guard::Notifier).to have_received(:notify).with(
            '2 successes / 0 failures / 0 errors / 0 pending',
            title: notifier::SUCCESS_TITLE,
            image: :success,
            priority: -2
          )
        end
      end
      context 'when status is true' do
        let(:message) { File.read('spec/fixtures/summary_failure_utfTerminal') }

        it 'sends notifcation with failure' do
          allow(Guard::Notifier).to receive(:notify)
          notifier.new(message, false).notify
          expect(Guard::Notifier).to have_received(:notify).with(
            '0 successes / 1 failure / 0 errors / 0 pending',
            title: notifier::FAILURE_TITLE,
            image: :failed,
            priority: 2
          )
        end
      end
    end
  end
end
