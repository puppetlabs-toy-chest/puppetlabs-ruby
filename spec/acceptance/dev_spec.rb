require 'spec_helper_acceptance'

describe 'ruby::dev class' do
  context 'without parameters' do
    it 'should run with no errors' do
      pp = <<-EOS
      class { 'ruby::dev': }
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

  context 'with custom dev packages specified' do
    it 'should run with no errors' do
      pp = <<-EOS
      class { 'ruby::dev':
        ruby_dev_packages => ['ruby-dev']
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)

      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('ruby-dev') do
      it {
        should be_installed
      }
    end
  end
end
