require '../lib/parser.rb'

parser = HTML::Parser.new
parser.string = '<html><head>
<title></title></head><body class="kk"=3 id="mm">Hello world</body></html>'
begin
  parser.parse
rescue HTML::InvalidTokenError => e
  $stderr.puts "Error: #{e}" 
end