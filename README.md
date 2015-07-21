#SMTP Reports Puppet module

####Table of Contents

1. [Overview](#overview)
2. [Module description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with the Logstash Reporter](#setup)
  * [The module manages the following](#the-module-manages-the-following)
  * [Requirements](#requirements)
4. [Usage - Configuration options and additional functionality](#usage)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Support - When you need help with this module](#support)
9. [Credits](#credits)



##Overview

This module manages the SMTP reporter which sends puppet reports to the configured email addresses.

##Module description

The smtpreports module sets up and configures the reporter

##Setup

###The module manages the following

* reporter configuration file.

###Requirements

* `json`
* `yaml`
* Master puppet.conf needs to use the SMTP reporter. 
```
[master]
report = true
reports = smtp
pluginsync = true
```
* Agent puppet.conf needs to send the reports to master. 
```
[agent]
report = true
pluginsync = true
```

##Usage

###Main class

####Basic usage

```puppet
class { 'smtpreports':
  smtp_server => 'host.example.com'
}
```

####Parameters

##### `smtp_server`
*Required.* Specifies the hostname or IP address of the SMTP server to use.
Default: undef.

##### `smtp_port`
Specifies the TCP port to use to connect to the SMTP server.
Default: 25.

##### `smtp_helo`
Specifies the hostname to use in the HELO command.
Default: 'localhost'.

##### `smtp_from`
*Required.* The email address that should be used as the sender.
Default: undef.

##### `smtp_to`
*Required.* A comma delimited list of email addresses that will receive the notifications.
Default: undef.

##### `smtp_use_auth`
Whether or not to use SMTP authentication.
Valid options: true, false. Default: false.

##### `smtp_auth_type`
*Required when smtp_use_auth is true.* The authentication type to use.
Valid options: plain, login, cram_md5. Default: undef.

##### `smtp_account`
*Required when smtp_use_auth is true.* The account/user to authenticate as.
Default: undef.

##### `smtp_secret`
*Required when smtp_use_auth is true.* The secret used to authenticate.
Default: undef.

##Limitations

This module has been built on and tested against Puppet 3.8 and higher.

The module has been tested on:

* CentOS 7

Other distro's that have been reported to work:

* RHEL 7

Testing on other platforms has been light and cannot be guaranteed.

##Development

##Support

##Credits
