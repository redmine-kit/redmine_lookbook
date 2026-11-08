#!/bin/sh
set -eu
cd /redmine
rm -f tmp/pids/server.pid

bin/rails db:migrate
if [ ! -f /data/.test-data-loaded ]; then
  bin/rails redmine_lookbook:load_test_data
  touch /data/.test-data-loaded
else
  # The test repositories are in tmp/, which a new container does not have.
  bin/rails redmine_lookbook:update_test_data
fi

exec bin/rails server -b 0.0.0.0 -p 3000
