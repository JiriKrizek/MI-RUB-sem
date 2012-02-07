require '../lib/parser.rb'

parser = HTML::Parser.new
parser.string = '<html><head>
<title></title></head><body class="kk mm " id="kk" style="mm">Hello world</body></html>'
begin
  parser.parse
rescue HTML::InvalidTokenError => e
  $stderr.puts "Error: #{e}" 
end


parser.string = '<!DOCTYPE html>
                <HTML>
                  <head>
                    <title></title>
                  </head>
                  <body class="kk mm " id="kk" style="mm">
                    Hello world
                  </body>
                </HTML>'
begin
  parser.parse
rescue HTML::InvalidTokenError => e
  $stderr.puts "Error: #{e}" 
end