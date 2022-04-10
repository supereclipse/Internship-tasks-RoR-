FROM ruby:2.6.5-alpine3.10

COPY . ./app

WORKDIR ./app/hw1

RUN bundle install

EXPOSE 8080

ENTRYPOINT ["ruby","lib/sinatra_server.rb"]
