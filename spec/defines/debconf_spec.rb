require 'spec_helper'
require 'hiera'

describe 'phpmyadmin::debconf', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { 'barfoo' }

      let :params do
        {
          debconf_package: 'foobar'
        }
      end

      context 'compile' do
        it { is_expected.to compile }
      end
    end
  end
end
