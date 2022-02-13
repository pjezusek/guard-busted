# frozen_string_literal: true

RSpec.describe Guard::Busted do
  it 'has a version number' do
    expect(Guard::BustedVersion::VERSION).not_to be nil
  end
end
