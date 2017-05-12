require 'spec_helper_acceptance'

describe 'puppet_phpmyadmin::vhost' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-EOS
        class { 'phpmyadmin':
        }

        ::phpmyadmin::vhost{ 'beaker':
         vhost_enabled => true,
         ssl           => false,
         conf_dir      => '/etc/apache2/conf-enabled'
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end

  context 'files provisioned' do
    describe file('/etc/apache2/sites-enabled/20-beaker.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Include' }
      its(:content) { is_expected.to match 'phpmyadmin.conf' }
    end
  end
end
