class fail2ban::config () {
  File {
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service[$fail2ban::params::fail2ban_service_name],
  }

  file { $fail2ban::params::fail2ban_global_config:
    content => template('fail2ban/jail.conf.erb'),
  }

  file { '/etc/fail2ban/filter.d/apache-w00tw00t.conf':
    source => 'puppet:///modules/fail2ban/apache-w00tw00t.conf'
  }

  file { '/etc/fail2ban/filter.d/nginx-proxy.conf':
    source => 'puppet:///modules/fail2ban/nginx-proxy.conf',
  }

  file { '/etc/fail2ban/filter.d/nginx-auth.conf':
    source => 'puppet:///modules/fail2ban/nginx-auth.conf',
  }

  file { '/etc/fail2ban/filter.d/nginx-nohome.conf':
    source => 'puppet:///modules/fail2ban/nginx-nohome.conf',
  }

  file { '/etc/fail2ban/filter.d/nginx-noscript.conf':
    source => 'puppet:///modules/fail2ban/nginx-noscript.conf',
  }

  file { '/etc/fail2ban/filter.d/nginx-login.conf':
    source => 'puppet:///modules/fail2ban/nginx-login.conf',
  }

  if $fail2ban::latest_filters
  {
    file { '/etc/fail2ban/filter.d':
      source  => 'puppet:///modules/fail2ban/latest',
      recurse => true,
    }
  }

  concat { $fail2ban::params::fail2ban_section_config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'jail.local_header':
    target  => $fail2ban::params::fail2ban_section_config,
    content => "# This file contains rules for fail2ban, each rules is put here using concat plugin and will be added automatically\n\n",
    order   => '01',
  }

}
