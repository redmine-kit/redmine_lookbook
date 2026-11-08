module RedmineLookbook
  # Renders wiki text with a chosen text formatting (CommonMark or Textile)
  # without changing Redmine's setting in the database.
  module TextFormatting
    module_function

    def with(format, &block)
      return yield unless Redmine::WikiFormatting.format_names.include?(format.to_s)

      SettingsOverride.with(text_formatting: format.to_s, &block)
    end

    def sample(format)
      file = format.to_s == "textile" ? "textile.txt" : "common_mark.md"
      File.read(File.join(RedmineLookbook.root, "previews", "redmine_lookbook", "wiki", file))
    end
  end
end
