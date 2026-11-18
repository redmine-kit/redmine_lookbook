namespace :redmine_kit_lookbook do
  desc "Load Redmine's test data for previews into a new, empty Redmine"
  task load_test_data: :environment do
    abort "Refusing to load test data in production." if Rails.env.production?

    count = RedmineKit::Lookbook::TestData.load!
    puts "Loaded #{count} tables of Redmine's test data. Sign in as admin / admin, or jsmith / jsmith."
    puts "Test repositories: #{RedmineKit::Lookbook::TestRepositories.ready.join(', ').presence || 'none (see the log)'}."
  rescue RedmineKit::Lookbook::TestData::ExistingDataError => e
    abort e.message
  end

  desc "Add what the previews need to a Redmine with Redmine's test data (test repositories and more)"
  task update_test_data: :environment do
    abort "Refusing to change data in production." if Rails.env.production?
    abort "Redmine's test data is not loaded. Run redmine_kit_lookbook:load_test_data first." unless RedmineKit::Lookbook::TestData.loaded?

    RedmineKit::Lookbook::TestData.update!
    puts "Test repositories: #{RedmineKit::Lookbook::TestRepositories.ready.join(', ').presence || 'none (see the log)'}."
  end
end
