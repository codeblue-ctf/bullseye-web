FROM ruby:2.6.4

WORKDIR /usr/src/bulls-eye-web
COPY Gemfile* ./
RUN bundle install

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn

COPY . .

RUN yarn

EXPOSE 3000
CMD ["/bin/bash", "-c", "rails db:migrate && rails db:seed && rails assets:precompile && rails s -p 3000 -b 0.0.0.0"]
