# == Class bookkeeper::users
#
class bookkeeper::users inherits bookkeeper {
  if $user_manage == true {
    group { $group:
      ensure => $group_ensure,
      gid    => $gid,
    }
    user { $user:
      ensure     => $user_ensure,
      home       => $user_home,
      shell      => $shell,
      uid        => $uid,
      comment    => $user_description,
      gid        => $group,
      managehome => $user_managehome,
      require    => Group[$group],
    }
  }
}
