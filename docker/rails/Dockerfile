FROM ruby:2.5.7

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

ENV RAILS_ROOT /cook-with

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler:2.1.4
RUN bundle install

#プロジェクトフォルダ内のすべてのファイルをRailsコンテナ内にコピーする
COPY . .

#ソケット通信のためのディレクトリを作成
RUN mkdir -p tmp/sockets
