# frozen_string_literal: true

RSpec.describe Guard::BustedVersion do
  let(:version_module) { described_class }

  it 'has a version number' do
    expect(version_module::VERSION).not_to be_nil
  end
end
