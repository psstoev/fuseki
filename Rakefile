require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :skeptic do
  OPTS = '--no-semicolons --line-length 80 --max-nesting-depth 2 --methods-per-class 10 --lines-per-method 5'.freeze
  fuseki_dir = Dir.new('lib/fuseki')
  file_names = fuseki_dir.select { |file_name| file_name =~ /.+\.rb$/ }
  files = file_names.map { |file| File.join fuseki_dir.path, file }
  files.each do |file|
    system(['skeptic', OPTS, file].join ' ')
  end
end
