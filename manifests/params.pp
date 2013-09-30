class fail2ban::params () {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $fail2ban_service_name   = 'fail2ban'
      $fail2ban_package_name   = 'fail2ban'
      $fail2ban_section_config = '/etc/fail2ban/jail.local'
      $fail2ban_global_config  = '/etc/fail2ban/jail.conf'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

