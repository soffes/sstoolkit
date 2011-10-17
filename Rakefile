appledoc_options = [
  '--output Documentation',
  '--project-name SSToolkit',
  '--project-company \'Sam Soffes\'',
  '--company-id com.samsoffes',
  "--project-version #{`cat VERSION`.strip}",
  '--keep-intermediate-files',
  '--create-html',
  '--templates ~/Library/Application\ Support/appledoc/Templates/',
  '--no-repeat-first-par',
  '--verbose']

namespace :docs do
  desc 'Clean docs'
  task :clean do
    `rm -rf Documentation`
  end
  
  desc 'Install docs'
  task :install => [:'docs:clean'] do
    `appledoc #{appledoc_options.join(' ')} --create-docset --install-docset SSToolkit/*.h`
  end
  
  desc 'Publish docs'
  task :publish => [:'docs:clean'] do
    extra_options = [
      '--create-docset',
      '--publish-docset',
      '--install-docset',
      '--docset-atom-filename com.samsoffes.sstoolkit.atom',
      '--docset-feed-url http://docs.sstoolk.it/%DOCSETATOMFILENAME',
      '--docset-package-url  http://docs.sstoolk.it/%DOCSETPACKAGEFILENAME'
      ]
    `appledoc #{appledoc_options.join(' ')} #{extra_options.join(' ')} SSToolkit/*.h`
  end
end
