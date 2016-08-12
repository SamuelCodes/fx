desc "polls for quotes"
task :poll => :environment do
  QuoteSet.poll
end
