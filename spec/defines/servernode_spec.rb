require 'spec_helper'
require 'hiera'

describe 'phpmyadmin::servernode', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { 'barfoo' }

      let :params do
        {
          server_group: 'foobar',
          myserver_name: 'foobar.my.com',
          verbose_name: 'foobar.verbose',
          target: '/foobar'
        }
      end

      context 'compile' do
        it { is_expected.to compile }
      end
    end
  end
end
