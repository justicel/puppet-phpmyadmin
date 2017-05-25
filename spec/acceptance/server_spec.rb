require 'spec_helper_acceptance'

describe 'puppet_phpmyadmin::server' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-EOS
        class { 'phpmyadmin':
        }

        ::phpmyadmin::server{ 'beaker':
          config_file  => '/etc/phpmyadmin/conf.d/config.beaker.php',
          absolute_uri => 'http://beaker.foobar'
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provisioned' do
    describe file('/etc/phpmyadmin/conf.d/config.beaker.php') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'File managed by Puppet' }
      its(:content) { is_expected.to match 'beaker.foobar' }
      its(:content) { is_expected.to match 'PropertiesIconic' }
      its(:content) { is_expected.to match 'PmaAbsoluteUri' }
    end
  end
end
