FROM ruby:3.1.2-bullseye

RUN apt-get update && apt-get install build-essential postgresql-client libpq-dev libjpeg-dev libpng-dev libtiff-dev libwebp-dev libvips git webp -y

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]