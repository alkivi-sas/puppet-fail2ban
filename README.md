# Fail2ban Module

This module will install and configure a fail2ban server and allow you to add other rules

## Usage

### Minimal server configuration

```puppet
class { 'fail2ban': }
```
This will do the typical install, configure and service management. 

### More server configuration

```puppet
class { 'fail2ban'
  ignoreip   = ['127.0.0.1/8'],
  bantime    = 600,
  maxretry   = 3,
  backend    = 'auto',
  destemail  = 'root@localhost',
  banaction  = 'iptables-multiport',
  mta        = 'sendmail',
  protocol   = 'tcp',
  chain      = 'INPUT',
  action_    = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]',
  action_mw  = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
            %(mta)s-whois[name=%(__name__)s, dest="%(destemail)s", protocol="%(protocol)s", chain="%(chain)s"]',
  action_mwl = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
              %(mta)s-whois-lines[name=%(__name__)s, dest="%(destemail)s", logpath=%(logpath)s, chain="%(chain)s"]',
  action     = '%(action_mwl)s',
  motd       = true,
}
```

### Rules configuration

```puppet
fail2ban::section{ 'apache':
    content => "enabled  = true
port     = http,https
filter   = apache-auth
logpath  = '/var/log/apache/*.log'
maxretry = 6"
}
```

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
