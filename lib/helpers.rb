include Nanoc3::Helpers::XMLSitemap
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

def select_filter(item)
  ext = item[:extension].nil? ? nil : item[:extension].split('.').last
  case ext
    when "erb"
      filter :erb
    when "haml", nil?
      filter :haml
    when "md", "markdown"
      filter :erb
      filter :rdiscount
    when "html"
    else
      raise "Filter is not configured for #{item.identifier} in #{__FILE__}"
  end
end

## Takes an item and turns it into a dir w/ index.html
def route_naked(item)
  url = item[:content_filename].gsub(/^content/, '')
  return nil if url.match(/index\.html/)
  ext = "." + item[:extension]
  if ext.match(/(\.[a-zA-Z0-9]+){2}$/)
    url.gsub!(ext, '/index.html')
  end
  url
end

## Stolen from https://github.com/unthinkingly/unthinkingly-blog/blob/master/lib/helpers.rb
# Hyphens are converted to sub-directories in the output folder.
#
# If a file has two extensions like Rails naming conventions, then the first extension
# is used as part of the output file.
#
#   sitemap.xml.erb # => sitemap.xml
#
# If the output file does not end with an .html extension, item[:layout] is set to 'none'
# bypassing the use of layouts.
#
def route_path(item)
  # in-memory items have not file
  return item.identifier + "index.html" if item[:content_filename].nil?

  url = item[:content_filename].gsub(/^content/, '')

  # determine output extension
  extname = '.' + item[:extension].split('.').last
  outext = '.haml'
  if url.match(/(\.[a-zA-Z0-9]+){2}$/) # => *.html.erb, *.html.md ...
    outext = '' # remove 2nd extension
  elsif extname.match /\.(scss|sass)/
    outext = '.css'
  elsif extname == '.js'
    outext = '.js'
  else
    outext = '.html'
  end
  url.gsub!(extname, outext)

  if url.include?('-')
    url = url.split('-').join('/')  # /2010/01/01-some_title.html -> /2010/01/01/some_title.html
  end

  url
end