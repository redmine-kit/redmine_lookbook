# frozen_string_literal: true

require_relative "../test_helper"

module RedmineKit
  module Lookbook
    class PageRendererTest < ActiveSupport::TestCase
      # The preview's own request, on http://redmine.example.org (port 80).
      Controller = Struct.new(:request, :params)

      def renderer
        request = ActionDispatch::TestRequest.create("HTTP_HOST" => "redmine.example.org", "rack.url_scheme" => "http")
        PageRenderer.new(Controller.new(request, ActionController::Parameters.new))
      end

      # [a redirect's Location, the path a page preview follows, or nil]
      CASES = [
        ["/issues", "/issues"],
        ["/issues?set_filter=1&sort=id", "/issues?set_filter=1&sort=id"],
        ["projects/ecookbook", "/projects/ecookbook"],
        ["http://redmine.example.org/my/page", "/my/page"],
        ["http://redmine.example.org:80/login?back_url=%2F", "/login?back_url=%2F"],
        ["/projects/ecookbook/wiki/日本語", "/projects/ecookbook/wiki/%E6%97%A5%E6%9C%AC%E8%AA%9E"],
        # another server, scheme or port: never followed
        ["http://evil.example.com/my/page", nil],
        ["//evil.example.com/my/page", nil],
        ["https://redmine.example.org/my/page", nil],
        ["http://redmine.example.org:8080/my/page", nil],
        ["http://redmine.example.org.evil.example.com/", nil],
        ["http://redmine.example.org@evil.example.com/", nil],
        ["javascript:alert(1)", nil],
        ["mailto:admin@example.net", nil],
        # not a URI
        ["http://[redmine.example.org/", nil]
      ].freeze

      CASES.each do |location, expected|
        test "a redirect to #{location} is #{expected ? "followed to #{expected}" : 'not followed'}" do
          followed = renderer.send(:same_server_path, location)
          expected ? assert_equal(expected, followed) : assert_nil(followed)
        end
      end
    end
  end
end
