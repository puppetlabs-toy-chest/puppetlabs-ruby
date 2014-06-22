require 'spec_helper_acceptance'

describe 'ruby class' do
  context 'without parameters' do
    it 'should run with no errors' do
      pp = <<-EOS
      class { 'ruby': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('ruby') do
      it {
        should be_installed
      }
    end

  end

  context 'with rubygems' do
    it 'should run with no errors' do
      pp = <<-EOS
      class { 'ruby':
        gems_version => 'latest',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('rubygems') do
      it {
        should be_installed
      }
    end
  end
end
