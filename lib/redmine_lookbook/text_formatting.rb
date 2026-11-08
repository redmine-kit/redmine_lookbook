module RedmineLookbook
  # Renders wiki text with a chosen text formatting (CommonMark or Textile)
  # without changing Redmine's setting in the database.
  module TextFormatting
    KEY = :redmine_lookbook_text_formatting

    # Prepended to Setting's singleton class while the plugin is enabled.
    module SettingOverride
      def text_formatting
        Thread.current[KEY] || super
      end
    end

    module_function

    def with(format)
      previous = Thread.current[KEY]
      Thread.current[KEY] = format.to_s if Redmine::WikiFormatting.format_names.include?(format.to_s)
      yield
    ensure
      Thread.current[KEY] = previous
    end

    def sample(format)
      file = format.to_s == "textile" ? "textile.txt" : "common_mark.md"
      File.read(File.join(RedmineLookbook.root, "previews", "redmine_lookbook", "wiki", file))
    end
  end
end
