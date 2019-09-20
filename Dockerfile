FROM ruby:2.6.3-stretch

RUN gem install rails

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs mysql-client

COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock
RUN bundle install
