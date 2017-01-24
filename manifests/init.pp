# Class: pgweb
# ===========================
#
# Full description of class pgweb here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'pgweb': }
#
# Authors
# -------
#
# Ryan Armstrong <ryan@cavaliercoder.com>
#
# Copyright
# ---------
#
# Copyright 2017 Ryan Armstrong
#
class pgweb (
  $bindir         = $::pgweb::params::bindir,
  $package_manage = $::pgweb::params::package_manage,
  $package_file   = $::pgweb::params::package_file,
  $package_url    = $::pgweb::params::package_url,
  $package_path   = $::pgweb::params::package_path,
  $service_manage = $::pgweb::params::service_manage,
  $service_name   = $::pgweb::params::service_name,
  $service_ensure = $::pgweb::params::service_ensure,
  $service_enable = $::pgweb::params::service_enable,
  $service_user   = $::pgweb::params::service_user,
  $url            = undef,
  $host           = undef,
  $port           = undef,
  $user           = undef,
  $password       = undef,
  $database       = undef,
  $ssl            = undef,
  $bind           = undef,
  $listen         = undef,
  $authuser       = undef,
  $authpass       = undef,
  $skipopen       = false,
  $sessions       = false,
  $prefix         = undef,
  $readonly       = true,
  $locksession    = false,
  $bookmark       = undef,
) inherits pgweb::params {
  class { '::pgweb::install' : } ->
  class { '::pgweb::service' : }
}
