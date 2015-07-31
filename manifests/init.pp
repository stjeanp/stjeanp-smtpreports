# = Class: smtpreports
#
# A puppet report processor that sends an email for a failed runs.
#
# This class installs and sets up the report processor on your Puppet Master.
#
# == Actions:
#   - template smtpreports.yaml configuration file
#
# === Parameters:
#
# [*smtp_server*]
#   (string) SMTP server hostname
#   (default: undef)
#   Example: mail.example.com
#
# [*smtp_port*]
#   (integer) The TCP port the SMTP server is listening on
#   (default: 25)
#
# [*smtp_helo*]
#   (string) The hostname to put in the HELO
#   (default: localhost)
#   Example: puppetmaster.example.com
#
# [*smtp_from*]
#   (string) The email address to send from
#   (default: undef)
#
# [*smtp_to*]
#   (string) The email address to send to
#   (default: undef)
#
# [*smtp_use_auth*]
#   (boolean) Does the SMTP connection need authentication
#   (default: false)
#
# [*smtp_auth_type*]
#   (string) The type of authentication to use, one of 'plain', 'login', or
#            'cram_md5'
#   (default: undef)
#
# [*smtp_account*]
#   (string) The account to use with SMTP authentication
#   (default: undef)
#
# [*smtp_secret*]
#   (string) The secret to use with SMTP authentication
#   (default: undef)
#
# == Sample Usage:
#
#    class { 'smtpreports':
#      smtp_server  => 'mail.example.com',
#    }
#

class smtpreports (
  $smtp_server    = $smtpreports::params::smtp_server,
  $smtp_port      = $smtpreports::params::smtp_port,
  $smtp_helo      = $smtpreports::params::smtp_helo,
  $smtp_from      = $smtpreports::params::smtp_from,
  $smtp_to        = $smtpreports::params::smtp_to,
  $smtp_use_auth  = $smtpreports::params::smtp_use_auth,
  $smtp_auth_type = $smtpreports::params::smtp_auth_type,
  $smtp_account   = $smtpreports::params::smtp_account,
  $smtp_secret    = $smtpreports::params::smtp_secret,
) inherits smtpreports::params {

  validate_string($smtp_server)
  validate_integer($smtp_port)
  validate_string($smtp_helo)
  validate_string($smtp_from)
  validate_string($smtp_to)
  validate_bool($smtp_use_auth)
  if $smtp_auth_type {
    validate_string($smtp_auth_type)
    if !member(['plain', 'login', 'cram_md5'], $smtp_auth_type) {
      fail('smtp_auth_type must be one of "plain", "login", or "cram_md5"!')
    }
    validate_string($smtp_account)
    validate_string($smtp_secret)
  }

  file {'smtpreports-yaml-config':
    ensure  => present,
    path    => "${::puppet_confdir}/smtpreports.yaml",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/smtpreports.yaml.erb"),
  }
}
