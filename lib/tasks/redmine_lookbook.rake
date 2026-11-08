namespace :redmine_lookbook do
  desc "Load Redmine's test data for previews into a new, empty Redmine"
  task load_test_data: :environment do
    abort "Refusing to load test data in production." if Rails.env.production?

    count = RedmineLookbook::TestData.load!
    puts "Loaded #{count} tables of Redmine's test data. Sign in as admin / admin, or jsmith / jsmith."
  rescue RedmineLookbook::TestData::ExistingDataError => e
    abort e.message
  end
end
