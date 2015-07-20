# = Class: smtpreports::params
#
# The parameters and their defaults for the SMTP puppet report processor

class smtpreports::params {
  $smtp_server    = undef
  $smtp_port      = 25
  $smtp_use_auth  = false
  $smtp_auth_type = undef
  $smtp_account   = undef
  $smtp_secret    = undef

  if str2bool($::is_pe) {
    $puppet_user    = 'pe-puppet'
    $puppet_confdir = '/etc/puppetlabs/puppet'
  } else {
    $puppet_user    = 'puppet'
    $puppet_confdir = '/etc/puppet'
  }
}
