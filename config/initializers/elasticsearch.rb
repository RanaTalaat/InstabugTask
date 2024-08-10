# config/initializers/elasticsearch.rb

Elasticsearch::Model.client = Elasticsearch::Client.new(
  hosts: ['http://elasticsearch:9200']  # Match this with your Docker Compose service name and port
)
