# Based on https://github.com/standardfile/ruby-server/blob/master/Dockerfile

FROM ubuntu:16.04

ENV PROJECT_REPO=https://github.com/standardfile/ruby-server
ENV PROJECT_COMMIT=5bf417af20f4ccd98f1872bd0d8586bdbd224f13
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
RUN npm install -g bower

RUN git clone $PROJECT_REPO $PROJECT_DIR && \
    cd $PROJECT_DIR && \
    git checkout $PROJECT_COMMIT

WORKDIR $PROJECT_DIR

RUN bundle install
RUN bower install --allow-root
RUN bundle exec rake assets:precompile

EXPOSE 3000

ENTRYPOINT [ "./docker/entrypoint" ]
CMD [ "start" ]
