source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git:[^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'metadata-json-lint'
gem 'puppetlabs_spec_helper', '>= 1.2.0'
gem 'simplecov'
gem 'puppet_facts'
gem 'rspec-puppet'
gem 'puppet-lint', '~> 2.0'
gem 'puppet-lint-alias-check'
gem 'puppet-lint-empty_string-check'
gem 'puppet-lint-file_ensure-check'
gem 'puppet-lint-file_source_rights-check'
gem 'puppet-lint-leading_zero-check'
gem 'puppet-lint-spaceship_operator_without_tag-check'
gem 'puppet-lint-trailing_comma-check'
gem 'puppet-lint-unquoted_string-check'
gem 'puppet-lint-variable_contains_upcase'

gem 'rspec',     '~> 2.0'   if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
gem 'rake',      '~> 10.0'  if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
gem 'json',      '<= 1.8'   if RUBY_VERSION < '2.0.0'
gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'

group :system_tests do
  if beaker_version = ENV['BEAKER_VERSION']
    gem 'beaker', *location_for(beaker_version)
  end
  if beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION']
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec',  :require => false
  end
  gem 'serverspec',    :require => false
  gem 'beaker-puppet_install_helper', :require => false
end

# vim:ft=ruby
