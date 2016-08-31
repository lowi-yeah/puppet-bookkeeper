# == Class bookkeeper::config
#
class bookkeeper::config inherits bookkeeper {

  file { $config:
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template($config_template),
    require => Class['bookkeeper::install'],
  }
}
