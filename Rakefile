# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'fuel_calculators'


RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]


path = File.expand_path(__dir__)
Dir.glob("#{path}/lib/fuel_calculators/tasks/**/*.rake").each { |f| import f }