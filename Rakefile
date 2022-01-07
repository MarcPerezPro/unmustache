# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'yard'

task default: %i[]

RuboCop::RakeTask.new(:lint)

RuboCop::RakeTask.new(:lint_fix) do |task|
  task.fail_on_error = false
  task.options = ['--auto-correct-all']
end

RSpec::Core::RakeTask.new(:test)

YARD::Rake::YardocTask.new(:doc)
