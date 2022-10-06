require './lib/httpclient'
require './lib/parser'

parser = Parser.new
client = HttpClient.new(parser)
client.fetch
client.print
