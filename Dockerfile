FROM ruby:2.3.1-slim

# Install build requirements for native gems
RUN apt-get update -qq && apt-get install -y build-essential postgresql-client-9.4 libpq-dev

# Define the root of the application
ENV RAILS_ROOT /var/www/fx
ENV RAILS_ENV production

# Ensure pids directory for app server
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Install application gems
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . .

# Reroute logs for docker collection
RUN touch log/production.log
RUN ln -sf /dev/stdout log/production.log

# Run rails server
CMD [ "./bin/poll" ]
