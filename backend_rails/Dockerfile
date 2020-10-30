FROM ruby:latest

WORKDIR /app
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# install chrome
WORKDIR /usr/local/share
# RUN apt-get install xvfb libxtst6 fonts-liberation -y
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN gem install bundler rake

WORKDIR /app
COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock
RUN bundle install

# docker build . -t edimossilva/memory_app_rails
# docker push edimossilva/memory_app_rails
