# Class: ruby::params
#
# This class handles the Ruby module parameters
#
# Parameters:
#   $ruby_dev = the name of the Ruby development libraries
# 
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ruby::params {

 case $operatingsystem {
    "centos": {
      $ruby_dev="ruby-devel"
    }
    "ubuntu": {
      $ruby_dev= [ "ruby-dev", "rake", "irb" ]
    }
 }

}

