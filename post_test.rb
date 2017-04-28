format = "%Y-%m-%d %H:%M:%S"
cmd = 'curl -H "Accept: application/json" -H "Content-type: application/json" http://localhost:3000/sensors/1/measured_results -X POST -d "{\"data\":[{\"raw_value\":'+rand.to_s+',\"measured_at\":\"'+Time.now.strftime(format)+'\"}]}"'
system(cmd)
