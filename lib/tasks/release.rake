
desc "Release"
task :release => :environment do
  if ENV["TEST"] == "true"
    sh "DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:schema:load db:seed"
  else
    sh "bundle exec rails db:migrate"
  end
end
