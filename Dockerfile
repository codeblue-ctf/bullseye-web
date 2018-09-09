FROM ruby:2.5

WORKDIR /usr/src/bulls-eye-web
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]