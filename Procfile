web: bundle exec puma -t 5:5 -p ${PORT:-3005}
worker: bundle exec sidekiq -e production
release: DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:schema:load db:seed
