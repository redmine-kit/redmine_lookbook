module RedmineLookbook
  # A page preview sends an internal request through the Rails application
  # while the preview's own request is running. In development, Rails would
  # reload changed code in that internal request and unload the constants
  # that the preview's request is still using. The preview's request has
  # already reloaded code when it started, so internal requests skip it.
  module ReloadGuard
    KEY = :redmine_lookbook_internal_request

    # Prepended to the singleton class of Rails.application.reloader.
    module ReloaderMethods
      def check!
        return false if Thread.current[KEY]

        super
      end
    end

    module_function

    def internal_request
      previous = Thread.current[KEY]
      Thread.current[KEY] = true
      yield
    ensure
      Thread.current[KEY] = previous
    end
  end
end
