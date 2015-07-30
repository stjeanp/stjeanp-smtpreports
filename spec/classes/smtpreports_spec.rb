require 'spec_helper'

describe 'smtpreports', :type => :class do
  context 'default' do
    let(:facts) { { :puppetversion => '3.7.5'} }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'puppet') }
  end

  context 'pe, pre-2015.2' do
    let(:facts) { { :is_pe => true } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'pe-puppet') }
  end

  context 'pe, >=2015.2' do
    let(:facts) { { :pe_server_version => "2015.2.0" } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'pe-puppet') }
  end

  context 'puppet 4' do
    let(:facts) { { :puppetversion => '4.0.0', :is_pe => false } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'puppet') }
  end
end
