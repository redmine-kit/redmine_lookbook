# A development Redmine with Redmine Lookbook. Not for production use.
FROM ruby:3.4-bookworm

ARG REDMINE_VERSION=7.0.3
# From https://www.redmine.org/releases/redmine-7.0.3.tar.gz.sha256
ARG REDMINE_SHA256=0b6b24c033341a9d7ad52cfcfa7b1bc913c191c7a604f740d863f16249dd3c15

RUN apt-get update \
  && apt-get install -y --no-install-recommends libsqlite3-dev imagemagick ghostscript \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /redmine
RUN curl -fsSL -o /tmp/redmine.tar.gz "https://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz" \
  && echo "${REDMINE_SHA256}  /tmp/redmine.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/redmine.tar.gz --strip-components=1 -C /redmine \
  && rm /tmp/redmine.tar.gz

COPY docker/database.yml config/database.yml
COPY docker/Gemfile.local Gemfile.local
COPY Gemfile plugins/redmine_lookbook/Gemfile
RUN bundle config set --local without test && bundle install --jobs 4

COPY docker/entrypoint.sh /usr/local/bin/redmine-lookbook-entrypoint
RUN chmod +x /usr/local/bin/redmine-lookbook-entrypoint

ENV RAILS_ENV=development REDMINE_LOOKBOOK=1
EXPOSE 3000
ENTRYPOINT ["redmine-lookbook-entrypoint"]
