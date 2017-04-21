require 'spec_helper'
require 'hiera'

describe 'phpmyadmin' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(
          network_eth0: '127.0.0.1',
          netmask_eth0: '127.0.0.1'
        )
      end

      context 'compile' do
        it { is_expected.to compile }
      end
    end
  end
end
