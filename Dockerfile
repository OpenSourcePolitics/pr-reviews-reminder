FROM ruby:3.2.0

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["ruby", "src/main.rb"]