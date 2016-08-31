# Install and configure an Apache Bookkeper Server
# Automatically starts one bookie. For a complete quorum, three instances need to be started
class bookkeeper (
  $command                               = $bookkeeper::params::command,
  $config_template                       = $bookkeeper::params::config_template,
  $config                                = $bookkeeper::params::config,
  $gz_remote                             = $bookkeeper::params::gz_remote,
  $gz_local                              = $bookkeeper::params::gz_local,
  $unzipped_local                        = $bookkeeper::params::unzipped_local,
  $bin_directory                         = $bookkeeper::params::bin_directory,

  $service_autorestart                   = hiera('bookkeeper::service_autorestart', $bookkeeper::params::service_autorestart),
  $service_enable                        = hiera('bookkeeper::service_enable', $bookkeeper::params::service_enable),
  $service_ensure                        = $bookkeeper::params::service_ensure,
  $service_manage                        = hiera('bookkeeper::service_manage', $bookkeeper::params::service_manage),
  $service_name                          = $bookkeeper::params::service_name,
  $service_retries                       = $bookkeeper::params::service_retries,
  $service_startsecs                     = $bookkeeper::params::service_startsecs,
  $service_stderr_logfile_keep           = $bookkeeper::params::service_stderr_logfile_keep,
  $service_stderr_logfile_maxsize        = $bookkeeper::params::service_stderr_logfile_maxsize,
  $service_stdout_logfile_keep           = $bookkeeper::params::service_stdout_logfile_keep,
  $service_stdout_logfile_maxsize        = $bookkeeper::params::service_stdout_logfile_maxsize,

  $gid                                   = $bookkeeper::params::gid,
  $group                                 = $bookkeeper::params::group,
  $group_ensure                          = $bookkeeper::params::group_ensure,
  $shell                                 = $bookkeeper::params::shell,
  $uid                                   = $bookkeeper::params::uid,
  $user                                  = $bookkeeper::params::user,
  $user_description                      = $bookkeeper::params::user_description,
  $user_ensure                           = $bookkeeper::params::user_ensure,
  $user_home                             = $bookkeeper::params::user_home,
  $user_manage                           = hiera('bookkeeper::user_manage', $bookkeeper::params::user_manage),
  $user_managehome                       = hiera('bookkeeper::user_managehome', $bookkeeper::params::user_managehome),

  $bookie_port                           = $bookkeeper::params::bookie_port,
  $allow_loopback                        = $bookkeeper::params::allow_loopback,
  $journal_directory                     = $bookkeeper::params::journal_directory,
  $ledger_directory                      = $bookkeeper::params::ledger_directory,
  $index_directory                       = $bookkeeper::params::index_directory,
  $zk_ledgers_root_path                  = $bookkeeper::params::zk_ledgers_root_path,
  $zk_servers                            = $bookkeeper::params::zk_servers,
  $zk_timeout                            = $bookkeeper::params::zk_timeout,
  $server_tcp_no_delay                   = $bookkeeper::params::server_tcp_no_delay
) inherits bookkeeper::params {
  validate_string($command)
  validate_string($config_template)
  validate_absolute_path($config)
  validate_string($gz_remote)
  validate_absolute_path($gz_local)
  validate_absolute_path($unzipped_local)
  validate_absolute_path($bin_directory)

  validate_bool($service_autorestart)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)
  if !is_integer($service_retries) { fail('The $service_retries parameter must be an integer number') }
  if !is_integer($service_startsecs) { fail('The $service_startsecs parameter must be an integer number') }
  if !is_integer($service_stderr_logfile_keep) {fail('The $service_stderr_logfile_keep parameter must be an integer number')}
  validate_string($service_stderr_logfile_maxsize)
  if !is_integer($service_stdout_logfile_keep) {fail('The $service_stdout_logfile_keep parameter must be an integer number')}
  validate_string($service_stdout_logfile_maxsize)

  if !is_integer($gid) { fail('The $gid parameter must be an integer number') }
  validate_string($group)
  validate_string($group_ensure)
  validate_absolute_path($shell)
  if !is_integer($uid) { fail('The $uid parameter must be an integer number') }
  validate_string($user)
  validate_string($user_description)
  validate_string($user_ensure)
  validate_absolute_path($user_home)
  validate_bool($user_manage)
  validate_bool($user_managehome)

  if !is_integer($bookie_port) { fail('The $bookie_port parameter must be an integer number') }
  validate_bool($allow_loopback)
  validate_absolute_path($journal_directory)
  validate_absolute_path($ledger_directory)
  validate_absolute_path($index_directory)
  validate_absolute_path($zk_ledgers_root_path)
  validate_string($zk_servers)
  if !is_integer($zk_timeout) { fail('The $zk_timeout parameter must be an integer number') }
  validate_bool($server_tcp_no_delay)

  include '::bookkeeper::users'
  include '::bookkeeper::install'
  include '::bookkeeper::config'
  include '::bookkeeper::service'

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up. You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'bookkeeper::begin': }
  anchor { 'bookkeeper::end': }

  Anchor['bookkeeper::begin']
  -> Class['::bookkeeper::users']
  -> Class['::bookkeeper::install']
  -> Class['::bookkeeper::config']
  ~> Class['::bookkeeper::service']
  -> Anchor['bookkeeper::end']
}
