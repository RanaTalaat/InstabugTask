# Use the official Ruby image from the Docker Hub
FROM ruby:3.3.4

# Install dependencies for the Rails application and other utilities
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs redis-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install bundler and then install the application gems
RUN gem install bundler -v '2.5.17' && bundle install

# Copy the rest of the application code into the container
COPY . .

# Ensure that the app directory is writable
RUN chown -R nobody:nogroup /app && \
    chmod -R 755 /app

# Switch to a non-root user for security reasons
USER nobody

# Expose port 3000 for the Rails server
EXPOSE 3000

# Define the command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
