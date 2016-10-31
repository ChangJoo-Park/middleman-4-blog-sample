###
# Page options, layouts, aliases and proxies
###

# Timezon
Time.zone = "Seoul"

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def get_taxonomies(slug = 'category')
    list = []
    blog.articles.select{ |i| i.data[slug].present? }.each do |article|
      list = list.push article.data[slug]
    end

    return list.inject(Hash.new(0)){|hash, a| hash[a] += 1; hash}
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end


# Blog
activate :blog do |blog|
  blog.sources   = "posts/:year-:month-:day-:title.html"
  blog.paginate = true
  blog.per_page = 6
  blog.permalink = "blog/{year}/{month}/{day}/{title}"
  blog.layout = "blog_layout"
  blog.summary_separator = /(READMORE)/
  blog.tag_template = "tag.html"
  blog.custom_collections = {
    category: {
      link: '/categories/{category}',
      template: '/category.html'
    }
  }
end
