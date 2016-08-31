# == Class bookkeeper::install
#
class bookkeeper::install inherits bookkeeper {
  file { 'binDirectory':
    ensure => directory,
    path   => $bin_directory
  }

  file { 'journalDirectory':
    ensure => directory,
    path   => $journal_directory
  }

  file { 'ledgerDirectory':
    ensure => directory,
    path   => $ledger_directory
  }

  file { 'indexDirectory':
    ensure => directory,
    path   => $index_directory
  }

  remote_file { 'packedJar':
    ensure  => present,
    path    => $gz_local,
    source  => $gz_remote,
    require => RemoteFile['binDirectory']
  }

  exec { 'untar':
    command => "tar -xzf ${gz_local}",
    require => RemoteFile['packedJar']
  }

  exec { 'move':
    command => "mv ${unzipped_local} ${bin_path}",
    require => Exec['untar']
  }
}