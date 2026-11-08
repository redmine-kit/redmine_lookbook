module RedmineLookbook
  # Overrides a few Redmine settings while a preview renders, without
  # changing Redmine's settings in the database.
  module SettingsOverride
    KEY = :redmine_lookbook_settings

    # Prepended to Setting's singleton class while the plugin is enabled.
    module SettingMethods
      def text_formatting
        SettingsOverride.value(:text_formatting) || super
      end

      # Redmine reads the theme from this setting in several places (the
      # stylesheets, icons and favicon, and the "theme-*" class on <body>).
      def ui_theme
        SettingsOverride.value(:ui_theme) || super
      end

      def thumbnails_enabled?
        value = SettingsOverride.value(:thumbnails_enabled)
        value.nil? ? super : value
      end
    end

    module_function

    def with(values)
      previous = Thread.current[KEY]
      Thread.current[KEY] = (previous || {}).merge(values)
      yield
    ensure
      Thread.current[KEY] = previous
    end

    def value(name)
      Thread.current[KEY]&.fetch(name, nil)
    end
  end
end
