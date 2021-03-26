
desc "Update all the rides for existing riders"
task :refresh_all_riders => :environment do
  Rider.find_each do |rider|
    FetchRidesJob.perform_async(rider.id)
  end
end
