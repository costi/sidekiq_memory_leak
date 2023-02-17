require 'sidekiq'

class EasyJob
  include Sidekiq::Job

  def perform(*args)
    # Do nothing for now
  end
end

require 'get_process_mem'

puts "Memory used: #{GetProcessMem.new.mb}"
puts 'generating job arguments...'
jobs = (1..900_000).map { |i| [i, i.to_s]  }
puts 'Done.'
puts "Memory used: #{GetProcessMem.new.mb}"

puts "sending a job with perform_async"
EasyJob.perform_async(jobs[0])
puts "Memory used: #{GetProcessMem.new.mb}"

puts "sending a 100 jobs with perform_bulk"
EasyJob.perform_bulk(jobs.first(100))
puts "Memory used: #{GetProcessMem.new.mb}"

puts 'enqueueing jobs to sidekiq'
EasyJob.perform_bulk(jobs)
puts "done enqueuing #{jobs.size} jobs to sidekiq"
puts "Memory used: #{GetProcessMem.new.mb}"

puts "Running GC"
GC.start
puts "Memory used: #{GetProcessMem.new.mb}"

puts 'clearing redis memory'
Redis.new.flushall
puts "Memory used: #{GetProcessMem.new.mb}"

puts 'Running in batches with perform_bulk'
jobs.each_slice(10000) do |smaller_jobs|
  EasyJob.perform_bulk(smaller_jobs)
end
GC.start
puts 'Done.'
puts "Memory used: #{GetProcessMem.new.mb}"

puts 'clearing redis memory'
Redis.new.flushall
puts "Memory used: #{GetProcessMem.new.mb}"
