require 'spec_helper'
describe 'ruby::dev', :type => :class do
  describe 'with default ruby' do
    let :pre_condition do
      'include ruby'
    end
    describe 'when called on Redhat' do
      let (:facts) do
        {
          :osfamily => 'RedHat',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby-devel').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
        let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby-devel')
        }
      end
    end

    describe 'when called on Amazon' do
      let (:facts) do
        {
          :osfamily => 'Amazon',
          :path => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby-devel').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
        let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby-devel')
        }
      end
    end

    describe 'when called on Debian' do
      let (:facts) do
        {
          :osfamily => 'Debian',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-dev').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('ri').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('pkg-config').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'ruby-bundler',
            'provider'  => 'apt',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby-dev').with_ensure('latest')
        }
        it {
          should contain_package('ri').with_ensure('latest')
        }
        it {
          should contain_package('pkg-config').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
        let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby-dev')
        }
        it {
          should_not contain_package('ri')
        }
        it {
          should_not contain_package('pkg-config')
        }
      end
    end
  end

  describe 'with ruby 1.9.1' do
    let :pre_condition do
      'class { \'ruby\': version => \'1.9.1\' }'
    end
    describe 'when called on Redhat' do
      let (:facts) do
        {
          :osfamily => 'RedHat',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end

    describe 'when called on Amazon' do
      let (:facts) do
        {
          :osfamily => 'Amazon',
          :path => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end
    describe 'when called on Debian' do
      let (:facts) do
        {
          :osfamily => 'Debian',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby1.9.1-dev').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('ri1.9.1').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('pkg-config').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'ruby-bundler',
            'provider'  => 'apt',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby1.9.1-dev').with_ensure('latest')
        }
        it {
          should contain_package('ri1.9.1').with_ensure('latest')
        }
        it {
          should contain_package('pkg-config').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
        let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby1.9.1-dev')
        }
        it {
          should_not contain_package('ri1.9.1')
        }
        it {
          should_not contain_package('pkg-config')
        }
      end
    end
  end

  describe 'with ruby 2.0.0' do
    let :pre_condition do
      'class { \'ruby\': version => \'2.0.0\' }'
    end
    describe 'when called on Redhat' do
      let (:facts) do
        {
          :osfamily => 'RedHat',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end

    describe 'when called on Amazon' do
      let (:facts) do
        {
          :osfamily => 'Amazon',
          :path => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end

    describe 'when called on Debian' do
      let (:facts) do
        {
          :osfamily => 'Debian',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby2.0-dev').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('ri').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('pkg-config').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'ruby-bundler',
            'provider'  => 'apt',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby2.0-dev').with_ensure('latest')
        }
        it {
          should contain_package('ri').with_ensure('latest')
        }
        it {
          should contain_package('pkg-config').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
        let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby2.0-dev')
        }
        it {
          should_not contain_package('ri')
        }
        it {
          should_not contain_package('pkg-config')
        }
      end
    end
  end

  describe 'with ruby 2.1.1' do
    let :pre_condition do
      'class { \'ruby\': version => \'2.1.1\' }'
    end
    describe 'when called on Redhat' do
      let (:facts) do
        {
          :osfamily => 'RedHat',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end

    describe 'when called on Amazon' do
      let (:facts) do
        {
          :osfamily => 'Amazon',
          :path => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby-devel').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rubygem-rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'bundler',
            'provider'  => 'gem',
            'require'   => 'Package[ruby]',
          })
        }
      end
    end

    describe 'when called on Debian' do
      let (:facts) do
        {
          :osfamily => 'Debian',
          :path     => '/usr/local/bin:/usr/bin:/bin'
        }
      end
      context 'with no parameters' do
        it {
          should contain_package('ruby2.0-dev').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('ri').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('pkg-config').with({
            'ensure' => 'installed',
          })
        }
        it {
          should contain_package('rake').with({
            'ensure'  => 'installed',
            'name'    => 'rake',
            'require' => 'Package[ruby]',
          })
        }
        it {
          should contain_package('bundler').with({
            'ensure'    => 'installed',
            'name'      => 'ruby-bundler',
            'provider'  => 'apt',
            'require'   => 'Package[ruby]',
          })
        }
      end
      context 'when using latest version' do
        let :params do
          {
            :ensure         => 'latest',
            :rake_ensure    => 'latest',
            :bundler_ensure => 'latest'
          }
        end
        it {
          should contain_package('ruby2.0-dev').with_ensure('latest')
        }
        it {
          should contain_package('ri').with_ensure('latest')
        }
        it {
          should contain_package('pkg-config').with_ensure('latest')
        }
        it {
          should contain_package('rake').with_ensure('latest')
        }
        it {
          should contain_package('bundler').with_ensure('latest')
        }
      end
      context 'when using custom packages' do
         let :params do
          {
            :ruby_dev_packages  => ['magic-ruby-dev','sparkly-ruby-dev'],
            :rake_package       => 'magic-rake',
            :bundler_package    => 'sparkly-bundler'
          }
        end
        it {
          should contain_package('magic-ruby-dev')
        }
        it {
          should contain_package('sparkly-ruby-dev')
        }
        it {
          should contain_package('rake').with_name('magic-rake')
        }
        it {
          should contain_package('bundler').with_name('sparkly-bundler')
        }
        it {
          should_not contain_package('ruby2.0-dev')
        }
        it {
          should_not contain_package('ri')
        }
        it {
          should_not contain_package('pkg-config')
        }
      end
    end
  end
end
