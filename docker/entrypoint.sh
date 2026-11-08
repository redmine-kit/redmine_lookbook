#!/bin/sh
set -eu
cd /redmine
rm -f tmp/pids/server.pid

bin/rails db:migrate
if [ ! -f /data/.test-data-loaded ]; then
  bin/rails redmine_lookbook:load_test_data CONFIRM=yes
  touch /data/.test-data-loaded
fi

exec bin/rails server -b 0.0.0.0 -p 3000
