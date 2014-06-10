# Defines an exec wrapper for bundle tasks
define ruby::bundle
(
  $command      = 'install',
  $option       = undef,
  $rails_env    = $ruby::params::rails_env,
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
  $umask        = undef,
  $unless       = undef,
) {

  require ruby

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

  case $command {
    'install': {
      validate_re(
        $option,
        ['--clean','--deployment','--gemfile=','--path=','--no-prune'],
        'Only bundler options supported for the install command are: clean, deployment, gemfile, path, and no-prune'
      )
      $real_command = join(['bundle',$command,$option],' ')
      $real_unless  = 'bundle check'
    }
    'exec': {
      $real_command = join(['bundle',$command,$option],' ')
      $real_unless  = $unless
    }
    'update':{
      validate_re(
        $option,
        ['--local','--source='],
        'Only bundler options supported for the update command are: local and source'
      )
      $real_command = join(['bundle',$command,$option],' ')
      $real_unless  = join(['bundle','outdated',$option],' ')
    }
    default: {
      fail ('Only the bundler commands install, exec, and update are supported.')
    }
  }

  exec{"ruby_bundle_${name}":
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
    umask        => $umask,
    unless       => $real_unless,
    require      => Package[$ruby::params::bundler_package]
  }

}