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
