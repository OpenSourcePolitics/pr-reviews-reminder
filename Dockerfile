FROM ruby:3.2.0

ENV APP_ENV=production \
    PORT=8080

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["ruby", "src/main.rb"]