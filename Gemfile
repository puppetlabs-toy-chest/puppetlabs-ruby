source 'https://rubygems.org'

group :development do
  gem 'rspec-system',           :require => false
  gem 'rspec-system-puppet',    :require => false
  gem "beaker"
  gem "beaker-rspec"
  gem "travis"
  gem "travis-lint"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.4.0'
  gem "puppet-lint"
  gem "rspec-puppet"
  gem "rspec", '< 3.0.0'
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
end
