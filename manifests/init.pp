class fail2ban (
  $ignoreip   = ['127.0.0.1/8'],
  $bantime    = 600,
  $maxretry   = 3,
  $backend    = 'auto',
  $destemail  = 'root@localhost',
  $banaction  = 'iptables-multiport',
  $mta        = 'sendmail',
  $protocol   = 'tcp',
  $chain      = 'INPUT',
  $action_    = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]',
  $action_mw  = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
            %(mta)s-whois[name=%(__name__)s, dest="%(destemail)s", protocol="%(protocol)s", chain="%(chain)s"]',
  $action_mwl = '%(banaction)s[name=%(__name__)s, port="%(port)s", protocol="%(protocol)s", chain="%(chain)s"]
              %(mta)s-whois-lines[name=%(__name__)s, dest="%(destemail)s", logpath=%(logpath)s, chain="%(chain)s"]',
  $action     = '%(action_mwl)s',
  $motd       = true,
) {

  if($motd)
  {
    motd::register{ 'Fail2ban': }
  }

  # declare all parameterized classes
  class { 'fail2ban::params': }
  class { 'fail2ban::install': }
  class { 'fail2ban::config': }
  class { 'fail2ban::service': }

  # declare relationships
  Class['fail2ban::params'] ->
  Class['fail2ban::install'] ->
  Class['fail2ban::config'] ->
  Class['fail2ban::service']
}

