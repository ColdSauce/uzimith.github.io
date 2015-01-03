###
# Blog settings
###

Time.zone = "Tokyo"

activate :blog do |blog|
  blog.permalink = "{year}/{month}/{day}/{title}.html"
  blog.sources = "post/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  blog.layout = "layout"
  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end


###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.output_style = :nest
  config.line_comments = false
end
require 'compass-normalize'
require 'breakpoint'

###
# Sprockets
###

sprockets.append_path 'components'

###
# Page options, layouts, aliases and proxies
###

with_layout :layout do
  page "/*", :layout => "layout"
  page "/post/*", :layout => "post"
  page "/elements/*", :layout => false
  page "/feed.xml", layout: false
end


###
# Helpers
###

helpers do
  def lang(path)
    I18n.locale.to_s + "/" + path
  end

  def url(path)
    current_page.url + path
  end

  def html_import_tag(path)
    path = asset_path(:html, path)
    content_tag :link, "", rel: "import", href: path
  end
end

activate :automatic_image_sizes
activate :syntax, :line_numbers => true

configure :development do
  activate :livereload
end

set :markdown_engine, :redcarpet
set :markdown, tables: true, autolink: true, gh_blockcode: true, fenced_code_blocks: true, with_toc_data: true, smartypants: true, fenced_code_blocks: true
activate :rouge_syntax
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-58170674-1'
end

set :css_dir, 'style'
set :js_dir, 'js'
set :images_dir, 'images'
set :slim, { pretty: true, sort_attrs: false, format: :html }
Tilt::CoffeeScriptTemplate.default_bare = true

activate :disqus do |d|
  d.shortname = 'uzimith'
end

#deploy
activate :deploy do |deploy|
  deploy.method = :git
end

# activate :relative_assets

configure :build do
  set :slim, { pretty: false, sort_attrs: false, format: :html }
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  # set :http_prefix, "/Content/images/"
end
