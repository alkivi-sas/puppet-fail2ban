define fail2ban::section(
  $content,
  $order   = 10
)
{
  validate_string($content)

  concat::fragment{"fail2ban_section_$name":
    target  => $fail2ban::params::fail2ban_section_config,
    content => "[${name}]\n$content\n\n"
  }
}

