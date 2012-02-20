# A sample Guardfile
# More info at https://github.com/guard/guard#readme
#
#

guard 'coffeescript', :input => '_coffee', :output => '_javascripts', :bare => true do
end

guard 'sprockets', :destination => "js", :asset_root => "." do
  watch (%r{^_javascripts/[^\/]+\.js})
end

guard 'sass' do
  watch(%r{^_sass/.+\.s[ac]ss})
end

guard 'livereload' do
  watch(%r{_site/.+\.(css|js|html|png|jpg)})
end

guard 'shell' do
  watch(/(.*)/){|m| `jekyll` unless m =~ /^_site/ }
end
