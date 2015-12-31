FROM ruby:2.2
MAINTAINER uzimith
ENV APP_HOME /app

RUN apt-get update
RUN apt-get install -y nodejs

WORKDIR /tmp
ADD Gemfile* ./
RUN bundle install -j4

RUN rm /etc/ssh/ssh_config
ADD ./docker/config/ssh_config /etc/ssh/ssh_config

RUN git config --global user.email "uzimith@docker"
RUN git config --global user.name "uzimith.x9@gmail.com"

EXPOSE 4567

WORKDIR $APP_HOME
ADD . $APP_HOME

CMD ["middleman", "deploy"]
