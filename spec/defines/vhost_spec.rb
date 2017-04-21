require 'spec_helper'
require 'hiera'

describe 'phpmyadmin::vhost', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(
          network_eth0: '127.0.0.1',
          netmask_eth0: '127.0.0.1'
        )
      end

      let(:title) { 'barfoo' }

      let :params do
        {
          vhost_name: 'foovhost',
          docroot: '/foobar',
          conf_dir: '/foobar',
          conf_dir_enable: '/foobar'
        }
      end

      context 'compile' do
        it { is_expected.to compile }
      end

      context 'vhost template' do
        it do
          is_expected.to contain_apache__vhost('foovhost').with(
                           'ensure'  => 'present',
                           'docroot' => '/foobar'
                         )
        end
      end
    end
  end
end
