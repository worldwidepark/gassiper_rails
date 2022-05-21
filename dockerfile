FROM ruby:2.6.8

RUN apt-get update && apt-get install -y \
    imagemagick \
    build-essential \
    libpq-dev \
    nodejs

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs  

RUN npm install --global yarn

WORKDIR /gassiper_rails

COPY Gemfile Gemfile.lock /gassiper_rails/
RUN bundle install

