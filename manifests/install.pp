class fail2ban::install () {
  package { $fail2ban::params::fail2ban_package_name:
    ensure => installed,
  }
}
