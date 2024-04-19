# frozen_string_literal: true
require 'spec_helper'

RSpec.describe FuelCalculators::RequiredFuel::Formulas do

  describe 'the Apollo 11 Command and Service Module, ' \
           'with a weight of 28801 kg, to land it on Earth, ' \
           'the required amount of fuel will be' do
    it do
      expect(described_class.new.land(28801, 'earth')).to eq 9278
    end
  end

  describe 'When fuel adds weight to the ship,'\
           'so it requires additional fuel until the additional fuel is 0 or negative' do
    it do
      expect(described_class.new.additional_fuel_land(9278, 'earth')).to eq(9278 + 2960 + 915 + 254 + 40)
    end
  end

  describe 'when wrong Celestial Object' do
    it do
      expect { described_class.new.land(9278, 'wrong') }.to \
        raise_error(FuelCalculators::RequiredFuel::FormulasError, 'a wrong celestial object')
    end
  end
end
