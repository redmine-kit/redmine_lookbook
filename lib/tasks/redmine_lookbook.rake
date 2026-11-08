namespace :redmine_lookbook do
  desc "Load Redmine's test data for previews into a new, empty Redmine"
  task load_test_data: :environment do
    abort "Refusing to load test data in production." if Rails.env.production?

    count = RedmineLookbook::TestData.load!
    puts "Loaded #{count} tables of Redmine's test data. Sign in as admin / admin, or jsmith / jsmith."
    puts "Test repositories: #{RedmineLookbook::TestRepositories.ready.join(', ').presence || 'none (see the log)'}."
  rescue RedmineLookbook::TestData::ExistingDataError => e
    abort e.message
  end

  desc "Add what the previews need to a Redmine with Redmine's test data (test repositories and more)"
  task update_test_data: :environment do
    abort "Refusing to change data in production." if Rails.env.production?
    abort "Redmine's test data is not loaded. Run redmine_lookbook:load_test_data first." unless RedmineLookbook::TestData.loaded?

    RedmineLookbook::TestData.update!
    puts "Test repositories: #{RedmineLookbook::TestRepositories.ready.join(', ').presence || 'none (see the log)'}."
  end
end
