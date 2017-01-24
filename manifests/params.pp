class pgweb::params {
  $version = '0.9.6'

  $binname = 'pgweb_linux_amd64'
  $bindir  = '/usr/local/bin'

  $package_manage = true
  $package_file   = "${binname}.zip"
  $package_url    = "https://github.com/sosedoff/pgweb/releases/download/v${version}/${package_file}"
  $package_path   = "/tmp/${package_file}"

  $service_manage = true
  $service_name   = 'pgweb'
  $service_ensure = 'running'
  $service_enable = true
  $service_user   = $service_name
}
