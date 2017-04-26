require 'httpclient'

client = HTTPClient.new
client.debug_dev = $stderr

baseurl = 'http://handyapp-mock.herokuapp.com/'
url = baseurl

query = {'hoge' => 'moge' }
res = client.get(url, :query => query)

p res.headers
puts res.body





