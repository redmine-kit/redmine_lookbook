# frozen_string_literal: true

require_relative "../test_helper"

module RedmineKit
  module Lookbook
    class LookbookTest < ActiveSupport::TestCase
      include RedmineKit::Lookbook::TestHelper

      # [Rails environment, REDMINE_KIT_LOOKBOOK, whether the previews are on]
      CASES = [
        ["development", nil, true],
        ["development", "1", true],
        ["development", "0", false],
        ["test", nil, false],
        ["test", "1", true],
        ["production", nil, false],
        ["production", "0", false],
        # Always off in production, even when asked for: the previews render
        # Redmine's pages as an administrator for anyone who can open them.
        ["production", "1", false]
      ].freeze

      CASES.each do |env, setting, expected|
        test "in #{env} with REDMINE_KIT_LOOKBOOK=#{setting.inspect} the previews are #{expected ? 'on' : 'off'}" do
          with_lookbook_gem do
            with_env("REDMINE_KIT_LOOKBOOK" => setting) do
              with_rails_env(env) { assert_equal expected, RedmineKit::Lookbook.enabled? }
            end
          end
        end
      end

      test "off without the Lookbook gem, whatever the environment says" do
        skip "the Lookbook gem is installed" if defined?(::Lookbook)

        with_env("REDMINE_KIT_LOOKBOOK" => "1") do
          with_rails_env("development") { assert_not RedmineKit::Lookbook.enabled? }
        end
      end

      test "the test server runs with the plugin off, without Lookbook's route" do
        assert_not RedmineKit::Lookbook.enabled?
        assert_not(Rails.application.routes.routes.any? { |route| route.path.spec.to_s.start_with?("/lookbook") })
      end
    end
  end
end
