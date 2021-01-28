# frozen_string_literal: true

RSpec.describe Guard::BustedVersion do
  let(:version_class) { described_class }

  it 'has a version number' do
    expect(version_class::VERSION).not_to be nil
  end
end
