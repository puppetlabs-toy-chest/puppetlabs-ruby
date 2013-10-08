# == Class: ruby::dev
#
# This class installs Ruby development libraries
#
# Actions:
#   - Install RDoc, IRB, Rake and development libraries
#
class ruby::dev {

  require 'ruby'

  package { 'ruby-dev':
    ensure => installed,
    name   => $ruby::ruby_dev_real,
  }
}
