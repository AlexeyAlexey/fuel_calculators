# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

module FuelCalculators
  class Error < StandardError; end
end

require_relative 'fuel_calculators/version'
require_relative 'fuel_calculators/required_fuel/formulas'
require_relative 'fuel_calculators/required_fuel/calculator'
