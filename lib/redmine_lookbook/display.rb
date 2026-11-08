module RedmineLookbook
  # The options shown in the Lookbook toolbar. They follow Redmine's own
  # settings screen: a blank choice means Redmine's default.
  module Display
    module_function

    def options
      {
        theme: theme_choices,
        # Lookbook shows each key as the option's label ("Language").
        language: language_choices,
        layout: [["None (component only)", "none"], ["Redmine layout", "page"]],
        **server_option
      }
    end

    def theme_choices
      [["Default", ""]] + Redmine::Themes.themes.map { |theme| [theme.name, theme.id] }
    end

    # The same names and order as the language list in Redmine's settings.
    def language_choices
      helper = Object.new.extend(Redmine::I18n)
      [["Default (Redmine's default language)", ""]] + helper.languages_options(cache: false)
    end

    # Other Redmine servers that run this plugin, from REDMINE_LOOKBOOK_SERVERS
    # ("label=url,label=url"). Choosing one opens the same preview there.
    def servers
      ENV.fetch("REDMINE_LOOKBOOK_SERVERS", "").split(",").filter_map do |entry|
        label, url = entry.split("=", 2).map(&:strip)
        [label, url.chomp("/")] if label.present? && url.present?
      end
    end

    def server_option
      return {} if servers.empty?

      { server: [["This server (Redmine #{Redmine::VERSION})", ""]] + servers }
    end

    # Reads a display value from the request parameters Lookbook sends.
    def value(params, key)
      params.dig(:lookbook, :display, key).to_s.presence
    end

    # The id of the chosen theme, or nil for Redmine's default theme.
    def theme_id(params)
      id = value(params, :theme)
      id if id && Redmine::Themes.theme(id)
    end

    def locale(params)
      helper = Object.new.extend(Redmine::I18n)
      candidate = value(params, :language) || Setting.default_language
      helper.valid_languages.map(&:to_s).include?(candidate.to_s) ? candidate.to_s : nil
    end

    def component_only?(params)
      value(params, :layout) != "page"
    end
  end
end
