# Memory leak in perform_bulk

```bash
bundle exec ruby bulk.rb
Memory used: 34.93359375
generating job arguments...
Done.
Memory used: 147.37890625
enqueueing jobs to sidekiq
done enqueuing 900000 jobs to sidekiq
Memory used: 424.69921875
Running GC
Memory used: 418.04296875
clearing redis memory
Memory used: 418.04296875
```
