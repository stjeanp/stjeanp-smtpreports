require 'spec_helper'

describe 'smtpreports', :type => :class do
  after :each do
    Facter.clear
    Facter.clear_messages
  end

  context 'puppet oss 3.7.5' do
    let(:facts) { { :puppetversion => '3.7.5', :is_pe => false } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'root') }
  end

  context 'pe, pre-2015.2' do
    let(:facts) { { :puppetversion => '3.8.1', :is_pe => true } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'root') }
  end

  context 'pe, >=2015.2, puppet master' do
    let(:facts) { { :puppetversion => '4.2.1', :pe_server_version => "2015.2.0", :is_pe => false } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'root') }
  end

  context 'puppet 4.2.1 AIO agent' do
    let(:facts) { { :puppetversion => '4.2.1', :is_pe => false } }
    it { should contain_class('smtpreports') }
    it { should contain_class('smtpreports::params') }
    it { should contain_file('smtpreports-yaml-config').with(:owner => 'root') }
  end
end
