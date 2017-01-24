class pgweb::install {
  if $::pgweb::package_manage {
    include ::archive

    archive { $::pgweb::package_path :
      ensure       => 'present',
      extract      => true,
      extract_path => '/tmp',
      source       => $::pgweb::package_url,
      creates      => "/tmp/${::pgweb::binname}",
      cleanup      => true,
    }

    file { "${::pgweb::bindir}/pgweb" :
      ensure  => 'file',
      source  => "/tmp/${::pgweb::binname}",
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'bin_t',
      require => Archive[$::pgweb::package_path],
    }
  }
}
