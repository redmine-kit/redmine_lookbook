namespace :redmine_lookbook do
  desc "Load Redmine's test data for previews. Replaces existing rows; run with CONFIRM=yes"
  task load_test_data: :environment do
    abort "Refusing to load test data in production." if Rails.env.production?
    unless ENV["CONFIRM"] == "yes"
      abort "This replaces the data in the Redmine database with Redmine's test data. " \
            "Run again with CONFIRM=yes to continue."
    end

    count = RedmineLookbook::TestData.load!
    puts "Loaded #{count} tables of Redmine's test data. Sign in as admin / admin, or jsmith / jsmith."
  end
end
