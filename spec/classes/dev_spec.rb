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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
          })
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
          })
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
          })
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
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
          should contain_package('rubygems-bundler').with({
            'ensure' => 'installed',
          })
        }
      end
    end

  end
end