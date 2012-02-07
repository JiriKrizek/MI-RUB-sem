require File.dirname(__FILE__) + "/../lib/validator.rb"

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
                    <title>kk</title>
                  </head>
                  <body class="kk mm " id="kk" style="mm">
                    <B>kk<B></B></B>
                    <I></I>
                    <U>dkd</U>
                    <H1>kk</H1>
                    <TABLE>
                      <TR>
                        <TH>kk</TH>
                        <TD>kk</TD>
                      </TR>
                      <TR>
                        <TH>kk</TH>
                        <TD>kk</TD>
                      </TR>
                    </TABLE>
                  </body>
                  </HTML>'
begin
  parser.parse
rescue HTML::InvalidTokenError => e
  $stderr.puts "Error: #{e}" 
rescue HTML::InvalidTagError => e
  $stderr.puts "Error: #{e}" 
rescue HTML::InvalidChildError => e
  $stderr.puts "Error: #{e}" 
rescue StandardError => e
  $stderr.puts "Error: #{e}" 
end