class GetFile
    include Sidekiq::Worker
    sidekiq_options queue: 'test_queue'

    def perform(args = {})
        puts "hello world"
    end
end
