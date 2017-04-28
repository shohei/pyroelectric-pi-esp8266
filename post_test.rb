format = "%Y-%m-%d %H:%M:%S"
baseurl = "http://localhost:3000"
url = baseurl + "/sensors/1/measured_results" 
cmd = 'curl -H "Accept: application/json" -H "Content-type: application/json" '+url+' -X POST -d "{\"data\":[{\"raw_value\":'+rand.to_s+',\"measured_at\":\"'+Time.now.strftime(format)+'\"}]}"'
system(cmd)
