#############################################################
#	Application
#############################################################

set :application, "notaryfly.com"
set :user, "root"
set :deploy_to, "/home/dominic/notaryfly.com"
set :use_sudo, false

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true

#############################################################
#	Servers
#############################################################

set :user, "root"
set :domain, "209.20.86.157"
server domain, :app, :web
role :db, domain, :primary => true


namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

#############################################################
#	Github
#############################################################

set :repository,  "git@github.com:thecosmicagency/notaryfly.com.git"
set :scm, "git"
set :scm_passphrase, "saosin15"
set :branch, "master"

#############################################################
#	Symlinks
#############################################################

namespace :customs do
  task :symlink_galleries, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/photos #{release_path}/public/photos
    CMD
  end
  
  task :symlink_tmp, :roles => :app do
    run <<-CMD
      sudo chmod 777 /home/dominic/notaryfly.com/current/tmp 
    CMD
  end
  
  task :symlink_attachments, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/attachments #{release_path}/public/attachments
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_1s #{release_path}/public/attachment_1s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_2s #{release_path}/public/attachment_2s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_3s #{release_path}/public/attachment_3s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_4s #{release_path}/public/attachment_4s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_5s #{release_path}/public/attachment_5s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/attachment_6s #{release_path}/public/attachment_6s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_1s #{release_path}/public/order_attachment_1s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_2s #{release_path}/public/order_attachment_2s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_3s #{release_path}/public/order_attachment_3s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_4s #{release_path}/public/order_attachment_4s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_5s #{release_path}/public/order_attachment_5s
    CMD
    
    run <<-CMD
    ln -nfs #{shared_path}/order_attachment_6s #{release_path}/public/order_attachment_6s
    CMD
  end
end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


#############################################################
#	After Deploy
#############################################################

after :deploy, "customs:symlink_galleries"
after :deploy, "customs:symlink_tmp"
after :deploy, "customs:symlink_attachments"
after :deploy, "passenger:restart"