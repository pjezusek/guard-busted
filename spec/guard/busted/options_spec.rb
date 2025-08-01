# frozen_string_literal: true

RSpec.describe Guard::BustedOptions do
  let(:options_class) { described_class }

  it 'has defaults' do
    expect(options_class::DEFAULTS).not_to be_nil
  end
end
