# Based on https://github.com/standardfile/ruby-server/blob/master/Dockerfile

FROM ubuntu:16.04

ENV PROJECT_REPO=https://github.com/standardfile/ruby-server
ENV PROJECT_COMMIT=20d74bf5fe22ca18737b00354d23ba06e6136bfe
ENV PROJECT_DIR=/data/src/

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get -y update && \
    apt-get -y install git build-essential ruby-dev ruby-rails libz-dev libmysqlclient-dev curl tzdata netcat && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get -y update && \
    apt-get -y install nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

RUN git clone $PROJECT_REPO $PROJECT_DIR && \
    cd $PROJECT_DIR && \
    git checkout $PROJECT_COMMIT

WORKDIR $PROJECT_DIR

RUN bundle install
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT [ "./docker/entrypoint" ]
CMD [ "start" ]
