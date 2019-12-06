require 'sidekiq'
require 'sidekiq/api'

Sidekiq.default_worker_options = { retry: 25 }

Sidekiq.configure_client do |config|
config.redis = {
    url: Settings.redis.url,
    namespace: Settings.redis.namespace
}

config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 1.hour
end
end

Sidekiq.configure_server do |config|
config.redis = {
    url: Settings.redis.url,
    namespace: Settings.redis.namespace
}

config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware, expiration: 1.hour
end
config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 1.hour
end
end

