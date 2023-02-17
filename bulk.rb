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
