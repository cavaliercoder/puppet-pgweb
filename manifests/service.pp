class pgweb::service {
  if $::pgweb::service_manage {
    $bindir       = $::pgweb::bindir
    $service_name = $::pgweb::service_name
    $service_user = $::pgweb::service_user

    $descr    = 'pgweb PostgreSQL client'
    $unitfile = "/usr/lib/systemd/system/${service_name}.service"
    $conffile = "/etc/sysconfig/${service_name}"

    $url      = $::pgweb::url
    $authuser = $::pgweb::authuser
    $authpass = $::pgweb::authpass

    if $url {
      $hostarg = ''
      $portarg = ''
      $userarg = ''
      $passarg = ''
      $dbarg   = ''
    } else {
      $hostarg = $::pgweb::host ? {
        undef   => '',
        default => " --host=${::pgweb::host}",
      }

      $portarg = $::pgweb::port ? {
        undef   => '',
        default => " --port=${::pgweb::port}",
      }

      $userarg = $::pgweb::user ? {
        undef   => '',
        default => " --user=${::pgweb::user}",
      }

      $passarg = $::pgweb::password ? {
        undef   => '',
        default => " --pass=${::pgweb::password}",
      }

      $dbarg = $::pgweb::database ? {
        undef   => '',
        default => " --db=${::pgweb::database}",
      }
    }

    $roarg = $::pgweb::readonly ? {
      true    => ' --readonly',
      default => '',
    }

    $args = [
      $hostarg,
      $portarg,
      $userarg,
      $passarg,
      $dbarg,
      $roarg,
    ]

    $argstr = join($args)
    $command  = "${bindir}/pgweb${argstr}"

    if $::pgweb::service_user != 'root' and $::pgweb::service_user != 0 {
      user { $service_user :
        ensure     => 'present',
        comment    => 'pgweb service account',
        shell      => '/usr/sbin/nologin',
        managehome => false,
        system     => true,
        before     => Service[$service_name],
      }
    }

    file { $unitfile :
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'systemd_unit_file_t',
      content => template("${module_name}/pgweb.service.erb"),
    }

    file { $conffile :
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0640',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
      content => template("${module_name}/pgweb.conf.erb"),
    }

    exec { 'reload pgweb unit file' :
      command     => '/bin/systemctl daemon-reload || :',
      refreshonly => true,
      subscribe   => File[$unitfile],
      notify      => Service[$service_name],
    }

    service { $service_name :
      ensure  => $::pgweb::service_ensure,
      enable  => $::pgweb::service_enable,
      require => [
        File[$unitfile],
        File[$conffile],
      ],
    }
  }
}
