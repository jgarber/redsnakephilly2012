require 'rubygems'
require 'sprockets'
require 'fileutils'
task :generate => :clean do
  Rake::Task['sass'].invoke
  Rake::Task['sprockets'].invoke
  Rake::Task['jekyll'].invoke
end

desc "Generate sass"
task :sass do
  sh %{sass --update _sass:css -t compact}
end

desc "Generate sprockets"
task :sprockets => :coffee do
  Dir.glob('_javascripts/*.js') do |js|
    secretary = Sprockets::Secretary.new(
      :asset_root   => ".",
      :load_path    => ["_javascripts/libs"],
      :source_files => [js]
    )

    # Generate a Sprockets::Concatenation object from the source files
    concatenation = secretary.concatenation
    # Write the concatenation to disk
    concatenation.save_to("js/"+File.basename(js))

    # Install provided assets into the asset root
    secretary.install_assets
    
  end

end

task :coffee do
  sh %{coffee -b -o _javascripts/ -c _coffee/}
end

task :clean do
  sh %{rm -rf _site}
end

task :jekyll do
  sh %{jekyll}
end
