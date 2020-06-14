FROM ruby:2.5.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                      libpq-dev \
                      vim
#yarnのインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

#Nodejsをバージョン指定してインストール
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get install nodejs

RUN mkdir /app_name 

ENV APP_ROOT /app_name 
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT