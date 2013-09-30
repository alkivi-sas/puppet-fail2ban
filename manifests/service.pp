class fail2ban::service () {
  service { $fail2ban::params::fail2ban_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

