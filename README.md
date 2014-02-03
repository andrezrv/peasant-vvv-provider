# Peasant VVV Provider

Peasant provides your [VVV][vvv] virtual machine with a preinstalled WordPress website (including your prefered themes and plugins) based on [WordPress Bareboner][wpbb] and an already configured instance of [Stage WP][stagewp] for your deployments. Just clone the repo, set up your configuration files, run `vagrant up` into your VVV folder, and you're done!

## Features

* A preinstalled WordPress website (including your prefered themes and plugins) based on [WordPress Bareboner][wpbb].
* Automatic creation of your MySQL user and database.
* A preconfigured [Stage WP][stagewp] instance for professional deployments, including [Capistrano][cap] and [Rubygems][rubygems] installation.
* All your project hosts automatically added to `/etc/hosts`
* Automatic configuration of an NGINX server block for your website.
* Automatic configuration of backup and maintenance tasks.
* Simplified folder synchronization.

## Requirements

* Using [VVV][vvv] for local development.

That's pretty much it :)

## Getting Started

1. `cd` to your VVV folder.
2. Clone Peasant: `git clone git://github.com:andrezrv/peasant-vvv-provider $vagrant_dir/config/custom/peasant`.
3. Go to `$vagrant_dir/config/custom/peasant`, copy `Config.example` to `Config`, and configure it as you need.
4. Copy `Customfile.example` to your VVV root, and modify it as necessary so it can read `$vagrant_dir/ebconfig/custom/peasant`, or just modify your current `Customfile`.
5. Run `vagrant up`. In some cases you should need to run `vagrant up --provision` to be sure the entire process is executed.

Once the provision ended, you should have your WordPress website and your Stage WP instance into the folder of your new web project. Also, you should find your new hosts inside `/etc/hosts` and your NGINX file into `$project_path/vvv-conf/vvv-nginx.conf`.

You can also run many instances of Peasant for different projects into the same VM. All you need to do is point to their `Config` files into your VVV's `Customfile`.

## How Does Peasant Work?

Peasant works by automatically configuring VVV's `provision-pre.sh` and `provision-post.sh` files to point to your Peasant `/provision` folder, executing all the tasks that live there, and taking advantage of the VVV features that allow custom database loading (with `init-custom.sql`), automatic modifications for `/etc/hosts` file (with `vvv-hosts`), custom NGINX configuration (via `vvv-nginx.conf`) and automatic site provisioning (using vvv-init).

## Extending

If you want to add or replace functionality, you can do it by creating the following files inside `$peasant_path/provision`:

* `vvv-init-setup-tasks-custom.sh`: For custom configuration of backups and maintenance tasks. 
* `vvv-init-setup-wordpress-custom.sh`: For custom configuration of your WordPress site.
* `vvv-init-setup-themes-custom.sh`: For custom installation and activation of themes.
* `vvv-init-setup-plugins-custom.sh`: For custom installation and activation of plugins.
* `vvv-init-setup-deploy-custom.sh`: For custom configuration of your deployment system.
* `vvv-init-setup-nginx-custom.sh`: For custom configuration of your project's NGINX server block.
* `vvv-init-setup-themes-pre.sh`: For all the tasks you need to run before installing themes. 
* `vvv-init-setup-themes-post.sh`: For all the tasks you need to run after installing themes.
* `vvv-init-setup-plugins-pre.sh`: For all the tasks you need to run before installing plugins. 
* `vvv-init-setup-plugins-post.sh`: For all the tasks you need to run after installing plugins. 

## How Do I Prevent Peasant From Running Every Effing Time?

Of course, you can always remove Peasant once you provided your project, but if that's not your case or you prefer Peasant to check your project for missing things once in a while without having it running on every `vagrant up`, you can do it in two ways:

* Remove the call to `$peasant_path/Config` into your VVV's `Customfile`.
* Create a file into your Peasant folder called `Lockfile`.

## Stability

This repo is an experiment that I started for making it easier for me to work on my own projects, so I cannot confirm that it will work just right out of the box on any environment, and that's why this is in a very Beta state at the moment. However, I think it must be interesting to have it here to see how VVV's auto provisioning works, and I'm willing to keep mantaining the project as long as someone (including me) finds it useful, so a future stable release is not out of the scope by any means.

## Contributing
If you feel like you want to help this project by adding something you think useful, you can make your pull request against the master branch :)

[vvv]: http://github.com/Varying-Vagrant-Vagrants/VVV
[wpbb]: http://github.com/andrezrv/wordpress-bareboner
[stagewp]: http://github.com/andrezrv/stage-wp
[cap]: http://github.com/capistrano/capistrano
[rubygems]: http://rubygems.org/pages/download
