# Memory leak in perform_bulk

```bash
Memory used: 35.0390625
generating job arguments...
Done.
Memory used: 147.703125
sending a job with perform_async
Memory used: 147.703125
sending a 100 jobs with perform_bulk
Memory used: 148.53125
enqueueing jobs to sidekiq
done enqueuing 900000 jobs to sidekiq
Memory used: 418.7890625
Running GC
Memory used: 412.08984375
clearing redis memory
Memory used: 412.08984375
Running in batches with perform_bulk
Done.
Memory used: 421.8828125
clearing redis memory
Memory used: 421.8828125
```
