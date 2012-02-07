require '../lib/parser.rb'

parser = HTML::Parser.new
parser.string = '<html><head><title></title></head><body class="kk">Hello world</body></html>'
parser.parse