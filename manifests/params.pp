#
# == Class bookkeeper::params
class bookkeeper::params {
  # basics
  $command             = '/etc/bookkeeper/bin/bookkeeper bookkeeper'
  $config_template     = 'bookkeeper/bk_server.conf.erb'
  $config_file         = '/etc/bookkeeper/conf/bk_server.conf'
  $gz_remote           = 'http://mirror.klaus-uwe.me/apache/zookeeper/bookkeeper/bookkeeper-4.3.0/bookkeeper-server-4.3.0-bin.tar.gz'
  $gz_local            = 'bookkeeper-server-4.3.0-bin.tar.gz'
  $unzipped_local      = '/tmp/bookkeeper-server-4.3.0'
  $bin_directory       = '/etc/bookkeeper/bin'
  $tmp_directory       = '/tmp'
  # service configuration
  $service_autorestart = true
  $service_enable      = true
  $service_ensure      = 'present'
  $service_manage      = false
  $service_name        = 'bookkeeper'
  $service_retries     = 999
  $service_startsecs   = 10
  $service_stderr_logfile_keep    = 10
  $service_stderr_logfile_maxsize = '20MB'
  $service_stdout_logfile_keep    = 5
  $service_stdout_logfile_maxsize = '20MB'
  # user configuration
  $gid                 = 53013
  $group               = 'bookkeeper'
  $group_ensure        = 'present'
  $shell               = '/bin/bash'
  $uid                 = 53013
  $user                = 'bookkeeper'
  $user_description    = 'Bookkeeper system account'
  $user_ensure         = 'present'
  $user_home           = '/home/bookkeeper'
  $user_manage         = true
  $user_managehome     = true
  # bookkeeper configuration
  $bookkeeper_port      = 3181
  $allow_loopback       = true
  $journal_directory    = '/etc/bookkeeper/data/journal'
  $ledger_directory     = '/etc/bookkeeper/data/ledger'
  $zk_ledgers_root_path = '/ledgers'
  $zk_servers           = 'zookeeper1:2181'
  $zk_timeout           = 10000
  $server_tcp_no_delay  = true
  case $::osfamily {
    'RedHat': {}
    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
    }
  }
}
