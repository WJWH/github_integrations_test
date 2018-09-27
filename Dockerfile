# VERY minimal dockerfile for demonstration purposes
FROM ruby:2.5.1

COPY . .
RUN bundle install

CMD bundle exec rackup
