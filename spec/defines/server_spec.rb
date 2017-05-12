require 'spec_helper'
require 'hiera'

describe 'phpmyadmin::server', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        [
          'package { "foobar": }'
        ]
      end

      let(:title) { 'barfoo' }

      let :params do
        {
          config_file: '/foobar',
          data_dir: '/foobar',
          apache_group: 'foobar',
          package_name: 'foobar'
        }
      end

      context 'compile' do
        it { is_expected.to compile }
      end
    end
  end
end
