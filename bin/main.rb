require '../lib/parser.rb'

parser = HTML::Parser.new
parser.string = "<html><head></head><body></body></html>"
parser.parse