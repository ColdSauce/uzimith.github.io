def format_date(date)
  date.strftime('%Y-%m-%d')
end

def site_title_logo
  site_title_logo_image
  rescue NameError
    nil
end

def title(title)
  @page_title = title
end

def page_description
  if current_article && current_article.summary(100)
    description = current_article.summary
  elsif @page_title
    description = @page_title + ' page of ' + site_title
  else
    description = site_description
  end
  # remove html tags
  description.gsub(/<("[^"]*"|'[^']*'|[^'">])*>/, '').gsub(/[\r\n]/, ' ')
end

def analytics_account
  google_analytics_account
  rescue NameError
    nil
end

def markdown(content)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  markdown.render(content)
end

def gist(url)
  "<script src='#{url}.js'></script>"
end

def strip_tags(text)
    doc = Nokogiri::HTML::DocumentFragment.parse text
    doc.inner_text
end
