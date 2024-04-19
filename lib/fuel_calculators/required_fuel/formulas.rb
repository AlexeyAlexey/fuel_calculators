# frozen_string_literal: true

module FuelCalculators
  module RequiredFuel
    class FormulasError < StandardError
      def initialize(msg = '')
        super
      end
    end

    class Formulas
      LAUNCH_CONSTANT_X = BigDecimal('0.042')
      LAUNCH_CONSTANT_Y = 33

      LANDING_CONSTANT_X = BigDecimal('0.033')
      LANDING_CONSTANT_Y = 42

      GRAVITY_REFERENCE = { 'earth' => BigDecimal('9.807'),
                            'moon' => BigDecimal('1.62'),
                            'mars' => BigDecimal('3.711') }.freeze

      attr_reader :gravity_reference,
                  :launch_constant_x,
                  :launch_constant_y,
                  :landing_constant_x,
                  :landing_constant_y

      def initialize(gravity_reference: {},
                     launch_constant_x: nil,
                     launch_constant_y: nil,
                     landing_constant_x: nil,
                     landing_constant_y: nil)
        @gravity_reference = GRAVITY_REFERENCE.merge(gravity_reference)
        @launch_constant_x = launch_constant_x || LAUNCH_CONSTANT_X
        @launch_constant_y = launch_constant_y || LAUNCH_CONSTANT_Y
        @landing_constant_x = landing_constant_x || LANDING_CONSTANT_X
        @landing_constant_y = landing_constant_y || LANDING_CONSTANT_Y
      end

      def launch(mass, celestial_obj)
        gravity = gravity_reference[celestial_obj] || raise(FormulasError, 'a wrong celestial object')

        (mass * gravity * launch_constant_x - launch_constant_y).floor
      end

      def land(mass, celestial_obj)
        gravity = gravity_reference[celestial_obj] || raise(FormulasError, 'a wrong celestial object')

        (mass * gravity * landing_constant_x - landing_constant_y).floor
      end

      def additional_fuel_land(mass, celestial_obj)
        acc = 0
        calc_mass = mass
        loop do
          break if calc_mass <= 0

          acc += calc_mass

          calc_mass = land(calc_mass, celestial_obj)
        end

        acc
      end

      def additional_fuel_launch(mass, celestial_obj)
        acc = 0
        calc_mass = mass
        loop do
          break if calc_mass <= 0

          acc += calc_mass

          calc_mass = launch(calc_mass, celestial_obj)
        end

        acc
      end
    end
  end
end
