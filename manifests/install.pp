# == Class bookkeeper::install
#
class bookkeeper::install inherits bookkeeper {
  file { $bin_directory:
    ensure => directory
  }

  file { 'journalDirectory':
    ensure => directory,
    path   => $journal_directory
  }

  file { 'ledgerDirectory':
    ensure => directory,
    path   => $ledger_directory
  }

  file { $tmp_directory:
    ensure => directory,
  }

  # remote_file { 'packedJar':
  #   ensure => present,
  #   path   => "${tmp_directory}/${gz_local}",
  #   source => $gz_remote
  # }

  exec { 'download':
    command => "/bin/wget ${gz_remote}",
    cwd     => $tmp_directory,
    require => File[$tmp_directory]
  }
}