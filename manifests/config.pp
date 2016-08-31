# == Class bookkeeper::config
#
class bookkeeper::config inherits bookkeeper {

  exec { 'untar':
    command => "/bin/tar -xzf ${gz_local}",
    cwd     => $tmp_directory,
    require => Class['bookkeeper::install']
  }

  exec { 'move':
    command => "/bin/mv ${unzipped_local} ${bin_directory}",
    require => Exec['untar']
  }

  file { $config_file:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template($config_template)
  }
}
