module RedmineLookbook
  # Lets the page renderer choose the user, theme and language of an internal
  # page request. The values are read from Rack env keys that only code in
  # the same process can set (HTTP headers become "HTTP_*" keys), so an
  # outside request cannot use them.
  module ApplicationControllerPatch
    ENV_USER = "redmine_lookbook.user"
    ENV_THEME = "redmine_lookbook.theme"
    ENV_LOCALE = "redmine_lookbook.locale"

    def self.prepended(base)
      base.around_action :redmine_lookbook_with_theme
    end

    def find_current_user
      return super unless request.env.key?(ENV_USER)

      id = request.env[ENV_USER]
      id == :anonymous ? nil : User.active.find_by(id: id)
    end

    def set_localization(user = User.current)
      super
      locale = request.env[ENV_LOCALE]
      set_language_if_valid(locale) if locale.present?
    end

    private

    def redmine_lookbook_with_theme(&block)
      theme = request.env[ENV_THEME]
      theme ? SettingsOverride.with(ui_theme: theme, &block) : yield
    end
  end
end
