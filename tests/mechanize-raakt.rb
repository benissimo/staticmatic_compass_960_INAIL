#!/usr/bin/env ruby
# Simple script to run basic accessibility tests on a given URL.

require 'rubygems'
require 'mechanize'
require 'raakt'
 
agent = Mechanize.new
page = agent.get("http://10.5.67.115:3042/casainail/applicazioni")
 
raakttest = Raakt::Test.new(page.body)
result = raakttest.all
 
if result.length > 0
  puts "Accessibility problems detected:"
  puts result
else
  puts "No measurable accessibility problems were detected."
end
