require '../lib/parser.rb'

parser = HTML::Parser.new
parser.string = '<html><head>
<title></title></head><body class="kk mm " cc="kk" id="mm" obsolete cc="m">Hello world</body></html>'
begin
  parser.parse
rescue HTML::InvalidTokenError => e
  $stderr.puts "Error: #{e}" 
end