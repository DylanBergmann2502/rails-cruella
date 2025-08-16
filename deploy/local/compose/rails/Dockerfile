# deploy/local/compose/rails/Dockerfile
FROM ruby:3.4.4-slim

# Install system dependencies
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    libyaml-dev \
    libffi-dev \
    libssl-dev \
    git \
    curl \
    wait-for-it \
    libjemalloc2 \
    nano \
    vim \
    sudo \
    bash-completion \
    ssh \
    postgresql-client \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

# Create development user and add to sudoers
RUN groupadd --gid 1000 dev-user \
    && useradd --uid 1000 --gid dev-user --shell /bin/bash --create-home dev-user \
    && echo dev-user ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/dev-user \
    && chmod 0440 /etc/sudoers.d/dev-user

# Configure jemalloc
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV RAILS_ENV=development

# Update Ruby build tools to latest versions
RUN gem update --system --no-document && \
    gem install bundler --no-document && \
    gem cleanup

# Set bundler configuration for development
RUN bundle config set --global path '/usr/local/bundle' && \
    bundle config set --global bin '/usr/local/bundle/bin' && \
    bundle config set --global jobs 4 && \
    bundle config set --global retry 3

WORKDIR /app

# Copy Gemfiles
COPY Gemfile Gemfile.lock* ./

# Install gems (this will generate proper Gemfile.lock)
RUN bundle install

# Copy scripts
COPY ./deploy/local/compose/rails/entrypoint /entrypoint
COPY ./deploy/local/compose/rails/start /start
COPY ./deploy/local/compose/rails/migrate /migrate
RUN sed -i 's/\r$//g' /entrypoint \
    && sed -i 's/\r$//g' /start \
    && sed -i 's/\r$//g' /migrate \
    && chmod +x /entrypoint /start /migrate

# Copy application code
COPY . .

ENTRYPOINT ["/entrypoint"]
