# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "/index.html", :layout => "home"

activate :livereload
activate :directory_indexes

data.competitions.each do |item|
  proxy "/competitions/archive/#{item.date}.html", "competitions-archive-template.html", :locals => {
      :comp => item
  }, :ignore => true
end

configure :build do
  activate :minify_css
end

helpers do
  def genEmbedded(id)
    if id.video
      html = '<div class="videoWrapper"><iframe src="https://www.youtube-nocookie.com/embed/'
      html += id.video
      html += '" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>'
    else
      html = '<img class="img-fluid" style="cursor: pointer;" src="/images/screenshots/' + id.screenshot + '"/>'
    end
    return html
  end
end