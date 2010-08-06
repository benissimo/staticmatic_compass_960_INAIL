#!/usr/bin/env ruby
#$Id: convert2haml.rb 52 2010-03-31 08:23:12Z bellis $
#
# Generates HAML files from HTML files.
# 

class ToHaml
  def initialize(path)
    @path = path
  end
  
  def convert!
    Dir["#{@path}/**/*.html"].each do |file|
      `html2haml #{file} #{file.gsub(/\.html$/, '.haml')}`
    end
  end
end

path = File.join(File.dirname(__FILE__), 'pages', 'includes')
ToHaml.new(path).convert!