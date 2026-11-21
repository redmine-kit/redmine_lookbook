# frozen_string_literal: true

require_relative "../test_helper"

module RedmineKit
  module Lookbook
    class SettingsOverrideTest < ActiveSupport::TestCase
      # Setting[] reads the override, as it does once RedmineKit::Lookbook.setup
      # has prepended SettingMethods (the plugin is off in the tests). Outside
      # SettingsOverride.with it calls Redmine's own Setting[].
      setup do
        Setting.singleton_class.prepend(SettingsOverride::SettingMethods) unless Setting.singleton_class < SettingsOverride::SettingMethods
      end

      test "overrides Redmine's settings in the block only" do
        before = Setting.ui_theme
        SettingsOverride.with(ui_theme: "alternate", thumbnails_enabled: true) do
          assert_equal "alternate", Setting.ui_theme
          assert_equal "1", Setting[:thumbnails_enabled]
          assert Setting.thumbnails_enabled?
        end
        assert_equal before, Setting.ui_theme
        assert_nil SettingsOverride.value(:ui_theme)
      end

      test "changes nothing in the database" do
        assert_no_changes -> { Setting.where(name: "ui_theme").pluck(:value) } do
          SettingsOverride.with(ui_theme: "alternate") { Setting.ui_theme }
        end
      end

      test "a nested block adds to the outer one and gives it back after" do
        SettingsOverride.with(ui_theme: "alternate", text_formatting: "textile") do
          SettingsOverride.with(ui_theme: "classic") do
            assert_equal "classic", Setting.ui_theme
            assert_equal "textile", Setting.text_formatting
          end
          assert_equal "alternate", Setting.ui_theme
        end
      end

      test "the override is restored when the block raises" do
        assert_raises(RuntimeError) do
          SettingsOverride.with(ui_theme: "alternate") { raise "preview failed" }
        end
        assert_nil SettingsOverride.value(:ui_theme)
        assert_nil Thread.current[SettingsOverride::KEY]
      end

      test "another thread doesn't see the override" do
        SettingsOverride.with(ui_theme: "alternate") do
          assert_nil Thread.new { SettingsOverride.value(:ui_theme) }.value
        end
      end

      test "a name that isn't one of Redmine's settings raises" do
        error = assert_raises(ArgumentError) { SettingsOverride.with(ui_thme: "alternate") { flunk } }
        assert_includes error.message, ":ui_thme"
        assert_nil Thread.current[SettingsOverride::KEY]
      end
    end
  end
end
