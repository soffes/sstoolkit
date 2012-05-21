version = `cat VERSION`.strip
output = Dir.pwd + '/Documentation'
appledoc_options = [
  "--output \"#{output}\"",
  '--project-name SSToolkit',
  '--project-company "Sam Soffes"',
  '--company-id com.samsoffes',
  "--project-version #{version}",
  '--keep-intermediate-files',
  '--create-html',
  '--no-repeat-first-par',
  '--verbose',
  '--create-docset',
  # '--docset-platform-family appledoc'
]

namespace :docs do
  desc 'Clean docs output'
  task :clean do
    `rm -rf Documentation`
  end
  
  desc 'Install docs'
  task :install => [:'docs:clean'] do
    `appledoc #{appledoc_options.join(' ')} --install-docset SSToolkit/*.h`
  end
  
  desc 'Create publishable docs'
  task :publish => [:'docs:clean'] do
    extra_options = [
      # '--publish-docset',
      '--docset-copyright "2012 Sam Soffes"',      
      '--docset-atom-filename com.samsoffes.sstoolkit.atom',
      '--docset-feed-url "http://docs.sstoolk.it/%DOCSETATOMFILENAME"',
      '--docset-package-url "http://docs.sstoolk.it/%DOCSETPACKAGEFILENAME"'
    ]
    `appledoc #{appledoc_options.join(' ')} #{extra_options.join(' ')} SSToolkit/*.h`
  end
end
