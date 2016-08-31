require 'spec_helper'

describe 'bookkeeper' do
  context 'supported operating systems' do
    ['RedHat'].each do |osfamily|
      ['RedHat', 'CentOS', 'Amazon', 'Fedora'].each do |operatingsystem|
        let(:facts) {{
          :osfamily        => osfamily,
          :operatingsystem => operatingsystem,
          :processorcount => 1,
          :ipaddress => '1.2.3.4'
        }}

        # default_broker_configuration_file  = '/etc/mosquitto/conf.d/mosquitto.conf'

        context "with explicit data (no Hiera)" do

          describe "bookkeeper with default settings on #{osfamily}" do
            let(:params)  {{ }}
            # We must mock $::operatingsystem because otherwise this test will
            # fail when you run the tests on e.g. Mac OS X.
            it { should compile.with_all_deps }

            #it { should contain_class('bookkeeper::params') }
            #it { should contain_class('bookkeeper') }
            #it { should contain_class('bookkeeper::users').that_comes_before('bookkeeper::install') }
            #it { should contain_class('bookkeeper::install').that_comes_before('bookkeeper::config') }
            #it { should contain_class('bookkeeper::config') }
            #it { should contain_class('bookkeeper::service').that_subscribes_to('bookkeeper::config') }
#
            ## it { should contain_package('bookkeeper').with_ensure('present') }
#
            #it { should contain_group('bookkeeper').with({
            #  'ensure'     => 'present',
            #  'gid'        => 53013,
            #})}
#
            #it { should contain_user('bookkeeper').with({
            #  'ensure'     => 'present',
            #  'home'       => '/home/bookkeeper',
            #  'shell'      => '/bin/bash',
            #  'uid'        => 53013,
            #  'comment'    => 'Bookkeeper system account',
            #  'gid'        => 'bookkeeper',
            #  'managehome' => true
            #})}

            #it { should contain_file('/opt/mosquitto/logs').with({
            #  'ensure' => 'directory',
            #  'owner'  => 'mosquitto',
            #  'group'  => 'mosquitto',
            #  'mode'   => '0755',
            #})}

#            it { should contain_file('/var/log/mosquitto').with({
#              'ensure' => 'directory',
#              'owner'  => 'mosquitto',
#              'group'  => 'mosquitto',
#              'mode'   => '0755',
#            })}

            # it { should contain_file(default_broker_configuration_file).with({
            #     'ensure' => 'file',
            #     'owner'  => 'root',
            #     'group'  => 'root',
            #     'mode'   => '0644',
            #   }).
            #   with_content(/\sport\s1883\s/)
            # }


            # it { should contain_supervisor__service('bookkeeper').with({
            #   'ensure'      => 'present',
            #   'enable'      => true,
            #   'command'     => 'service bookkeeper start',
            #   'user'        => 'bookkeeper',
            #   'group'       => 'bookkeeper',
            #   'autorestart' => true,
            #   'startsecs'   => 10,
            #   'retries'     => 999,
            #   'stopsignal'  => 'TERM',
            #   'stopasgroup' => false,
            #   'stopwait'    => 10,
            #   'stdout_logfile_maxsize' => '20MB',
            #   'stdout_logfile_keep'    => 5,
            #   'stderr_logfile_maxsize' => '20MB',
            #   'stderr_logfile_keep'    => 10,
            # })}
          end


          # describe "bookkeeper with disabled user management on #{osfamily}" do
          #   let(:params) {{
          #     :user_manage  => false,
          #   }}
          #   it { should_not contain_group('bookkeeper') }
          #   it { should_not contain_user('bookkeeper') }
          # end

          # describe "bookkeeper with custom user and group on #{osfamily}" do
          #   let(:params) {{
          #     :user_manage      => true,
          #     :gid              => 456,
          #     :group            => 'bookkeepergroup',
          #     :uid              => 123,
          #     :user             => 'bookkeeperuser',
          #     :user_description => 'Bookkeeper user',
          #     :user_home        => '/home/bookkeeperuser',
          #   }}

          #   it { should_not contain_group('bookkeeper') }
          #   it { should_not contain_user('bookkeeper') }

          #   it { should contain_user('bookkeeperuser').with({
          #     'ensure'     => 'present',
          #     'home'       => '/home/bookkeeperuser',
          #     'shell'      => '/bin/bash',
          #     'uid'        => 123,
          #     'comment'    => 'Bookkeeper user',
          #     'gid'        => 'bookkeepergroup',
          #     'managehome' => true,
          #   })}

          #   it { should contain_group('bookkeepergroup').with({
          #     'ensure'     => 'present',
          #     'gid'        => 456,
          #   })}
          # end

          # describe "bookkeeper with a custom port on #{osfamily}" do
          #   let(:params) {{
          #     :port => 9093,
          #   }}
          #   it { should contain_file(default_broker_configuration_file).with_content(/\sport\s9093\s/) }
          # end
        end

      end
    end
  end

  #context 'unsupported operating system' do
  #  describe 'bookkeeper without any parameters on Debian' do
  #    let(:facts) {{
  #      :osfamily => 'Debian',
  #    }}
#
  #    it { expect { should contain_class('bookkeeper') }.to raise_error(Puppet::Error,
  #      /The bookkeeper module is not supported on a Debian based system./) }
  #  end
  #end
end
