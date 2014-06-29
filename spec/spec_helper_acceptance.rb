require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

UNSUPPORTED_PLATFORMS = ['Suse','windows','AIX','Solaris']

unless ENV['RS_PROVISION'] == 'no'
  hosts.each do |host|
    if host['platform'] =~ /debian/
      # debian 6 doesn't have gems in path by default
      on host, 'echo \'export PATH=/var/lib/gems/1.8/bin/:${PATH}\' >> ~/.bashrc'
    end
    if host.is_pe?
      install_pe
    else
      install_puppet
      on host, "mkdir -p #{host['distmoduledir']}"
    end

  end
end

# code liberally borrowed from http://www.xkyle.com/getting-started-puppet-acceptance-tests-with-beaker/
RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
      puppet_module_install(:source => proj_root, :module_name => 'ruby')
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
