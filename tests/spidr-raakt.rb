#!/usr/bin/env ruby
# ruby compatibility headaches
# -- spidr uses nokogiri which has problems with libxml2 used by ruby 1.9.1

# Spiders a site, recording broken links (spidr)
# Each html page is checked for basic accessibility tests (raakt)
require 'rubygems'
require 'spidr'
require 'raakt'
require 'ruport'

site_url = 'http://10.5.67.115:3042/' #Ben's dev server
site_url = 'http://10.5.66.97/' #presentation server
#site_url = 'http://tenderlovemaking.com/'
#site_url = 'http://www.google.com/robots.txt'
#my_proxy = {:host => 'tmgmain.inailutenti.inail.pri', :port => '80', :user => 'inailutenti\yels016', :password => '12341234' } #this doesn't work...
#my_proxy = {:host => '10.5.67.115', :port => '5865'}
#my_proxy = {:host => '127.0.0.1', :port => '5865'} #launch ntlmaps if you need to browse via proxy.
my_proxy = nil #don't need proxy for private URLs


report_data = Ruport::Data::Table.new :column_names => ["Url", "Error", "Details"]

Spidr.site(site_url, :ignore_links => [/(apri|chiudi)/], :proxy => my_proxy) do |spider|
  #spider.pause!
  spider.every_failed_url { |url| report_data << [url, "failed to retrieve",""] }
  spider.every_timedout_page { report_data << [url, "timed out",""]}
  #spider.every_url { |url| puts "visit: #{url}"}
  spider.every_missing_page { report_data << [url, "missing",""]}
  
  #spider.every_css_page { |page| puts page.inspect}
  spider.every_html_page do |page|
    unless page.url.to_s === site_url.to_s #skip starting url...
      #puts page.title
      raakttest = Raakt::Test.new(page.body)
      result = raakttest.all
      if result.length > 0
  			for error in result
  				report_data << [page.url.to_s, error.eid.to_s, error.text]
  			end        
        #puts "#{page.url} Accessibility problems detected:"
        #puts result
      else
        #puts "No measurable accessibility problems were detected."
      end
    end
  end
  

#  servers = Set[]
#  spider.all_headers do |headers|
#    servers << headers['server']
#    p headers['server']
#  end
end

#write report data to file (HTML table only...)
File.open("result.htm", "w") do |file|
	file << report_data.to_html
end

File.open("result.pdf", "w") do |file|
	file << report_data.to_pdf
end