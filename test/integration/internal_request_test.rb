# frozen_string_literal: true

require_relative "../test_helper"

module RedmineKit
  module Lookbook
    # A page preview chooses its user, language and sudo mode through Rack env
    # keys of an internal request (ApplicationControllerPatch). A request from
    # outside can't set them: a server turns every HTTP header into an HTTP_*
    # key, so a header of the same name is ignored.
    class InternalRequestTest < Redmine::IntegrationTest
      fixtures :users, :email_addresses, :user_preferences, :roles, :members, :member_roles

      ADMIN_ID = 1

      # The patch as RedmineKit::Lookbook.setup prepends it when the plugin is
      # on (it is off in the tests: no Lookbook gem). Without the env keys it
      # leaves Redmine as it is.
      setup do
        ApplicationController.prepend(ApplicationControllerPatch) unless ApplicationController < ApplicationControllerPatch
      end

      test "the env key set by code in the process signs the request in" do
        get "/my/account", env: { ApplicationControllerPatch::ENV_USER => ADMIN_ID }
        assert_response :success
        assert_select "#account .user-login", text: "@admin"
      end

      # The header names a client could send for the user key, as a server
      # (Rack) puts them into the env: HTTP_ and the name in capitals, "-"
      # as "_".
      [
        "HTTP_REDMINE_KIT_LOOKBOOK.USER",
        "HTTP_REDMINE_KIT_LOOKBOOK_USER",
        "HTTP_REDMINE_KIT_LOOKBOOK"
      ].each do |key|
        test "the header #{key} doesn't sign the request in" do
          get "/my/account", env: { key => ADMIN_ID.to_s }
          assert_redirected_to %r{/login\?back_url=}
        end
      end

      test "headers named like the locale and sudo keys change nothing" do
        log_user("jsmith", "jsmith")
        get "/admin", headers: { "Redmine-Kit-Lookbook-Sudo" => "true" },
                      env: { "HTTP_REDMINE_KIT_LOOKBOOK.SUDO" => "true", "HTTP_REDMINE_KIT_LOOKBOOK.LOCALE" => "ja" }
        assert_response :forbidden
        assert_not_includes response.body, "lang=\"ja\""
      end

      test "the patch leaves a request without the env keys to Redmine" do
        log_user("jsmith", "jsmith")
        get "/my/account"
        assert_response :success
        assert_select "#account .user-login", text: "@jsmith"
      end
    end
  end
end
