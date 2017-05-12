require 'spec_helper_acceptance'

describe 'puppet_phpmyadmin' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-EOS
        class { 'phpmyadmin':
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'packages installed' do
    describe package('phpmyadmin') do
      it { is_expected.to be_installed }
    end
    describe package('php5-common') do
      it { is_expected.to be_installed }
    end
    describe package('php5-mysql') do
      it { is_expected.to be_installed }
    end
  end
  context 'files provisioned' do
    describe file('/etc/phpmyadmin/apache.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'phpmyadmin' }
    end
    describe file('/var/lib/phpmyadmin/config.inc.php') do
      it { is_expected.to exist }
    end
  end
end
