FROM ruby:2.5

WORKDIR /usr/src/bulls-eye-web
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["/bin/bash", "-c", "rails db:migrate && rails db:seed && rails assets:precompile && rails s -p 3000 -b 0.0.0.0"]
