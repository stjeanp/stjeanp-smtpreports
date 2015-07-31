# = Class: smtpreports::params
#
# The parameters and their defaults for the SMTP puppet report processor

class smtpreports::params {
  $smtp_server    = undef
  $smtp_port      = 25
  $smtp_helo      = 'localhost'
  $smtp_use_auth  = false
  $smtp_auth_type = undef
  $smtp_account   = undef
  $smtp_secret    = undef
  $smtp_from      = undef
  $smtp_to        = undef
}
