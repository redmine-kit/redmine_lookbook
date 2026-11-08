module RedmineLookbook
  # Overrides Redmine settings while a preview renders, without changing
  # Redmine's settings in the database.
  #
  #   SettingsOverride.with(thumbnails_enabled: true, ui_theme: "alternate") { ... }
  #
  # Redmine reads every setting through Setting[] (Setting.ui_theme and
  # Setting.thumbnails_enabled? are defined on top of it), so overriding it
  # covers all settings. true and false become Redmine's "1" and "0".
  module SettingsOverride
    KEY = :redmine_lookbook_settings

    # Prepended to Setting's singleton class while the plugin is enabled.
    module SettingMethods
      def [](name)
        value = SettingsOverride.value(name)
        value.nil? ? super : value
      end
    end

    module_function

    def with(values)
      previous = Thread.current[KEY]
      Thread.current[KEY] = (previous || {}).merge(normalize(values))
      yield
    ensure
      Thread.current[KEY] = previous
    end

    def value(name)
      Thread.current[KEY]&.fetch(name.to_sym, nil)
    end

    def normalize(values)
      values.to_h.to_h do |name, value|
        value = "1" if value == true
        value = "0" if value == false
        [name.to_sym, value]
      end
    end
  end
end
