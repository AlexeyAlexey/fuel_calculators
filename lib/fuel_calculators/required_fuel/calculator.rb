# frozen_string_literal: true

module FuelCalculators
  module RequiredFuel
    class CalculatorError < StandardError
      def initialize(msg = '')
        super
      end
    end

    class Calculator
      attr_reader :ship_mass

      def initialize(ship_mass, farmulas, setts: {})
        @current_fuel_mass = 0
        @farmulas = farmulas
        @ship_mass = ship_mass
      end

      def self.calc(ship_mass,
                    flight_route,
                    farmulas = ::FuelCalculators::RequiredFuel::Formulas.new,
                    setts: {})

        new(ship_mass, farmulas, setts:).calc(flight_route)
      end

      def calc(flight_route)
        flight_route.reverse.each do |(action, celestial_obj)|

          @current_fuel_mass += case action
            when :launch
              launch_fuel_mass = @farmulas.launch(ship_mass + @current_fuel_mass, celestial_obj)

              @farmulas.additional_fuel_launch(launch_fuel_mass, celestial_obj)
            when :land
              land_fuel_mass = @farmulas.land(ship_mass + @current_fuel_mass, celestial_obj)

              @farmulas.additional_fuel_land(land_fuel_mass, celestial_obj)
            else
              raise CalculatorError.new('a wrong action')
            end
        end

        @current_fuel_mass
      end
    end
  end
end
