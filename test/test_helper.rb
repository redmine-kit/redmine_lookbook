# frozen_string_literal: true

# Coverage of the plugin's own files (init.rb, lib/) by its tests, when bin/test
# asks for it (COVERAGE=1 bin/test sets PLUGIN_COVERAGE), written as Cobertura
# XML to coverage/coverage.xml. It starts before Redmine loads, so that the
# files are counted from the start; files no test loads count as not covered.
if ENV["PLUGIN_COVERAGE"] && !(defined?(SimpleCov) && SimpleCov.running)
  require "simplecov"
  require "simplecov-cobertura"
  SimpleCov.command_name ENV["PLUGIN_COVERAGE"]
  SimpleCov.start do
    root File.expand_path("..", __dir__)
    # A glob from the plugin's folder: SimpleCov reads it from the current one (Redmine's).
    track_files "#{root}/{init.rb,lib/**/*.rb}"
    add_filter { |file| !file.project_filename.match?(%r{\A/(?:init\.rb\z|lib/)}) }
    enable_coverage :branch
    formatter SimpleCov::Formatter::CoberturaFormatter
  end
end

require File.expand_path("../../../test/test_helper", __dir__)

module RedmineKit
  module Lookbook
    # Shared setup of the plugin's tests. The test image has no Lookbook gem
    # (bin/test_image), so the plugin is off in them, as on a production
    # server; the tests call its own objects, and turn on the pieces that
    # RedmineKit::Lookbook.setup would add when a test needs them.
    module TestHelper
      # Runs the block with ENV changed, then restores it.
      def with_env(values)
        saved = values.keys.to_h { |key| [key, ENV.fetch(key, nil)] }
        values.each { |key, value| ENV[key] = value }
        yield
      ensure
        saved.each { |key, value| ENV[key] = value }
      end

      # Runs the block in the given Rails environment.
      def with_rails_env(name, &)
        Rails.stubs(:env).returns(ActiveSupport::EnvironmentInquirer.new(name))
        yield
      ensure
        Rails.unstub(:env)
      end

      # Runs the block with a stand-in for the Lookbook gem, which the test
      # image doesn't install, so that RedmineKit::Lookbook.enabled? looks
      # past it.
      def with_lookbook_gem
        return yield if defined?(::Lookbook)

        Object.const_set(:Lookbook, Module.new)
        begin
          yield
        ensure
          Object.send(:remove_const, :Lookbook)
        end
      end
    end
  end
end
