# Defines an exec wrapper for rake tasks
define ruby::rake
(
  $task         = undef,
  $rails_env    = $ruby::params::rails_env,
  $bundle       = false,
  $creates      = undef,
  $cwd          = undef,
  $environment  = undef,
  $user         = undef,
  $group        = undef,
  $logoutput    = undef,
  $onlyif       = undef,
  $path         = undef,
  $refresh      = undef,
  $refreshonly  = undef,
  $timeout      = undef,
  $tries        = undef,
  $try_sleep    = undef,
  $unless       = undef,
) {

  require ruby

  # validate_re($task,'^[a-z][a-z0-9]*((:[a-z][a-z0-9]*)?)*$',"The rake task '${task}' does not conform to an expected format.")

  # ensure minimum path requirements for bundler
  if $path {
    $real_path = unique(flatten([$path,$ruby::params::minimum_path]))
  } else {
    $real_path = $ruby::params::minimum_path
  }

  # merge the environment and rails_env parameters
  if $environment {
    $real_environment = unique(flatten([$environment,["RAILS_ENV=${rails_env}"]]))
  } else {
    $real_environment = "RAILS_ENV=${rails_env}"
  }

  $real_command = join(['rake',$task],' ')

  # wrapping rake tasks in bundler is a common practice, this makes sure
  # dependencies and requirements are met.
  if $bundle {
    ruby::bundle{"ruby_rake_${name}":
      command      => 'exec',
      option       => $real_command,
      rails_env    => $rails_env,
      creates      => $creates,
      cwd          => $cwd,
      environment  => $environment,
      user         => $user,
      group        => $group,
      logoutput    => $logoutput,
      onlyif       => $onlyif,
      path         => $path,
      refresh      => $refresh,
      refreshonly  => $refreshonly,
      timeout      => $timeout,
      tries        => $tries,
      try_sleep    => $try_sleep,
      unless       => $unless,
      require      => Package['rake']
    }
  } else {
    exec{"ruby_rake_${name}":
      command      => $real_command,
      creates      => $creates,
      cwd          => $cwd,
      environment  => $real_environment,
      user         => $user,
      group        => $group,
      logoutput    => $logoutput,
      onlyif       => $onlyif,
      path         => $real_path,
      refresh      => $refresh,
      refreshonly  => $refreshonly,
      timeout      => $timeout,
      tries        => $tries,
      try_sleep    => $try_sleep,
      unless       => $unless,
      require      => Package['rake']
    }
  }

}