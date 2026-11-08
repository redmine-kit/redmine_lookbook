module RedmineLookbook
  # Lets the page renderer choose the user and language of an internal page
  # request, and whether Redmine's sudo mode counts as confirmed. The values
  # are read from Rack env keys that only code in the same process can set
  # (HTTP headers become "HTTP_*" keys), so an outside request cannot use
  # them. The theme needs no key: the internal request runs in the thread of
  # the preview, where SettingsOverride already sets it.
  module ApplicationControllerPatch
    ENV_USER = "redmine_lookbook.user"
    ENV_LOCALE = "redmine_lookbook.locale"
    ENV_SUDO = "redmine_lookbook.sudo"

    def self.prepended(base)
      base.around_action :redmine_lookbook_around_action
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

    # Previews do not change the user's recently used projects in "Jump to a
    # project".
    def record_project_usage
      request.env.key?(ENV_USER) || super
    end

    private

    # As if the user had just entered their password: pages such as the
    # administration settings show their content instead of the password
    # form of Redmine's sudo mode.
    def redmine_lookbook_around_action
      Redmine::SudoMode.active! if request.env[ENV_SUDO]
      yield
    end
  end
end
