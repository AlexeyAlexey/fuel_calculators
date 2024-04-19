# frozen_string_literal: true
require 'spec_helper'

RSpec.describe FuelCalculators::RequiredFuel::Calculator do
  let(:formulas_class) { FuelCalculators::RequiredFuel::Formulas }

  describe 'when a default Formula object is used' do
    it "land earth" do
      expect(described_class.calc(28801, [[:land, 'earth']])).to eq 13447
    end

    it ":launch, 'earth', :land, 'moon', :launch, 'moon', :land, 'earth'" do
      route = [[:launch, 'earth'], [:land, 'moon'], [:launch, 'moon'], [:land, 'earth']]
      expect(described_class.calc(28801, route)).to eq 51898
    end
  end

  describe 'when a custom Formula object is set' do
    it 'land earth' do
      expect(described_class.calc(28801, [[:land, 'earth']], formulas_class.new)).to eq 13447
    end

    it ":launch, 'earth', :land, 'moon', :launch, 'moon', :land, 'earth'" do
      route = [[:launch, 'earth'], [:land, 'moon'], [:launch, 'moon'], [:land, 'earth']]
      expect(described_class.calc(28801, route, formulas_class.new)).to eq 51898
    end
  end
end
