# Based on https://github.com/standardnotes/syncing-server/blob/master/Dockerfile

FROM ruby:2-alpine

EXPOSE 3000

ENV PROJECT_REPO=https://github.com/standardnotes/syncing-server
ENV PROJECT_COMMIT=2a7abc3476b102cc349719c8e6a6cf7bac889399
ENV PROJECT_DIR=/src/

# Application settings.
ENV DB_HOST=standardnotes-db
ENV DB_DATABASE=standardnotes
ENV DB_USERNAME=standardnotes
ENV DB_PASSWORD=TO_BE_DEFINED
ENV DISABLE_USER_REGISTRATION=false
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
# Secret key should not include special characters:
ENV SECRET_KEY_BASE=TO_BE_DEFINED

# Build and test dependencies.
RUN apk add --update --no-cache \
    git \
    netcat-openbsd

# Application's dependencies.
RUN apk add --update --no-cache \
    build-base \
    mariadb-connector-c \
    mariadb-dev \
    nodejs \
    tzdata \
    zlib-dev

RUN git clone $PROJECT_REPO $PROJECT_DIR && \
    cd $PROJECT_DIR && \
    git checkout $PROJECT_COMMIT

WORKDIR $PROJECT_DIR

RUN gem install bundler:2.0.2
RUN bundle install

# See https://github.com/brianmario/mysql2/issues/1023
RUN mkdir ./lib/mariadb && ln -s /usr/lib/mariadb/plugin ./lib/mariadb/plugin

CMD "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"
