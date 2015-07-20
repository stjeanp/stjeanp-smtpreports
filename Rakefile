require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
end

ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_80chars')
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = ignore_paths
end

PuppetSyntax.exclude_paths = ignore_paths

task :metadata do
  sh "bundle exec metadata-json-lint metadata.json"
end

#task :spec do
#  sh %{rspec #{ENV['TEST'] || ENV['TESTS'] || 'spec'}}
#end

desc "Run lint and spec tests and check metadata format"
task :test => [
  :validate,
  :syntax,
  :lint,
  :spec,
  :metadata,
]
