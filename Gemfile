source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem 'rake'
  gem 'puppetlabs_spec_helper'
  gem 'rspec-puppet', :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem 'metadata-json-lint'
  gem 'puppet-lint',             :require => false
end

group :development do
  gem 'travis'
  gem 'travis-lint'
  gem 'puppet-blacksmith'
  gem 'guard-rake'
  gem 'rubocop', require: false
  gem 'pry'
  gem 'librarian-puppet'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '>= 3.8.0', '< 3.9.0', :require => false
end
