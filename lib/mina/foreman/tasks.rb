set :foreman_app, -> { fetch(:application_name) }
set :foreman_user, -> { fetch(:user) }
set :foreman_log,  -> { "#{fetch(:shared_path)}/log" }

set :foreman_format, 'systemd'
set :foreman_location, -> {
  case fetch(:foreman_format)
  when 'systemd'
    "/etc/systemd/system"
  else
    "/etc/init"
  end
}
set :foreman_service, -> {
  case fetch(:foreman_format)
  when 'systemd'
    "#{fetch(:foreman_app)}.target"
  else
    fetch(:foreman_app)
  end
}
set :foreman_procfile, 'Procfile'

namespace :foreman do

  desc 'Export the Procfile to init scripts'
  task :export do

    comment "-----> Exporting foreman procfile for #{fetch(:foreman_app)}"
    in_path "#{fetch(:current_path)}" do
      command %{ sudo bundle exec foreman export #{fetch(:foreman_format)} #{fetch(:foreman_location)} -a #{fetch(:foreman_app)} -u #{fetch(:foreman_user)} -d #{fetch(:current_path)} -l #{fetch(:foreman_log)} -f #{fetch(:foreman_procfile)} }
    end

    if fetch(:foreman_format) == 'systemd'
      comment "-----> Reloading and Enabling SystemD units for #{fetch(:foreman_app)}"
      command %{ sudo systemctl daemon-reload }
      command %{ sudo systemctl enable #{fetch(:foreman_app)}.target }
    end
  end

  desc "Start the application services"
  task :start do
    comment "-----> Starting #{fetch(:foreman_app)} services"

    case fetch(:foreman_format)
    when 'systemd'
      command %[sudo systemctl start #{fetch(:foreman_service)}]
    else
      command %[sudo start #{fetch(:foreman_service)}]
    end
  end

  desc "Stop the application services"
  task :stop do
    comment "-----> Stopping #{fetch(:foreman_app)} services"

    case fetch(:foreman_format)
    when 'systemd'
      command %[sudo systemctl stop #{fetch(:foreman_service)}]
    else
      command %[sudo stop #{fetch(:foreman_service)}]
    end
  end

  desc "Restart the application services"
  task :restart do
    comment "-----> Restarting #{fetch(:foreman_app)} services"

    case fetch(:foreman_format)
    when 'systemd'
      command %[sudo systemctl restart #{fetch(:foreman_service)}]
    else
      command %[sudo start #{fetch(:foreman_service)} || sudo restart #{fetch(:foreman_service)}]
    end
  end

  desc "Delete current init files"
  task :cleanup do
    comment "-----> Cleaning-up #{fetch(:foreman_app)} services"
    command %[sudo rm -r #{fetch(:foreman_location)}/#{fetch(:foreman_app)}*]
  end
end