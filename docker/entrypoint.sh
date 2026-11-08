#!/bin/sh
set -eu
cd /redmine
rm -f tmp/pids/server.pid

bin/rails db:migrate
# Load Redmine's test data into a new database. When it is already there,
# add what is missing, such as the test repositories in tmp/, which a new
# container does not have, or what a first start that stopped did not add.
if bin/rails runner 'exit(RedmineLookbook::TestData.loaded? ? 0 : 1)'; then
  bin/rails redmine_lookbook:update_test_data
else
  bin/rails redmine_lookbook:load_test_data
fi

exec bin/rails server -b 0.0.0.0 -p 3000
