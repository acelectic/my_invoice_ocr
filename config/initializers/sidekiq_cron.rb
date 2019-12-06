
# Bang-suffixed methods will remove jobs that are not present in the given hash/array,
# updates jobs that have the same names, and creates new ones when the names are previously unknown.
Sidekiq::Cron::Job.load_from_hash(
  YAML.load_file("config/sidekiq_cron_jobs.yml")
)