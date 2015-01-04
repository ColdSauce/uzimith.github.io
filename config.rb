###
# Site Settings
###

set :site_url, 'https://uzimith.github.io'
set :site_title, 'uzimith.github.io'
set :site_description, '日記 関心:Ruby/Vim/Web'
set :site_author, 'uzimith'
set :site_author_profile, '''
情報系学生

信号処理の研究室で脳波測ってます。

関心 : Vim / Ruby / Web
'''
set :site_author_image, 'profile.png'
set :reverse_title, false
set :social_links,
    twitter: 'https://twitter.com/uzimith',
    facebook: nil,
    github: 'https://github.com/uzimith',
    linkedin: nil
set :google_analytics_account, 'UA-58170674-1'

###
# Blog settings
###

Time.zone = "Tokyo"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # Permalink format
  blog.permalink = '{year}/{month}/{day}/{title}.html'
  # Matcher for blog source files
  blog.sources = 'posts/{year}-{month}-{day}-{title}.html'
  blog.summary_length = 250
  blog.default_extension = '.md'
  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = 'page/{num}'
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
require 'font-awesome-sass'

###
# Sprockets
###

sprockets.append_path 'components'

###
# Page options, layouts, aliases and proxies
###

with_layout :layout do
  page "/*", :layout => "layout"
  page "/posts/*", :layout => "post"
  page "/elements/*", :layout => false
  page '/feed.xml', layout: false
  page '/sitemap.xml', layout: false
  page '/robots.txt', layout: false
  page '/entries.json', layout: false
end


###
# Etc
###

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

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :slim, { pretty: true, sort_attrs: false, format: :html }
Tilt::CoffeeScriptTemplate.default_bare = true

activate :directory_indexes

activate :disqus do |d|
  d.shortname = 'uzimith'
end

#deploy
activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = :master
end

# activate :relative_assets

configure :build do
  set :slim, { pretty: false, sort_attrs: false, format: :html }
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  # set :http_prefix, "/Content/images/"
end
