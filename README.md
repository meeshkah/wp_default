Default Wordpress installation
------------------------------

Clean Wordpress repository with essential plugins and stripped Bones theme

This is based on the examples given in this article http://davidwinter.me/articles/2012/04/09/install-and-manage-wordpress-with-git/

How to
------
* _Prerequisites_
- My strong advice: do all the Ruby related stuff through RVM
- Capistrano
- Railsless-deploy gem (gem install railsless-deploy)
* _Local development_
- Clone the repository into an empty folder
- Initiate submodules by invoking "git submodule update --init --recursive"
- Change the salts in the wp-config.php file (use this link for convenience https://api.wordpress.org/secret-key/1.1/salt/)
- Create wp-config.local.php using the wp-config.default.php template.
- To update Wordpress use 'git fetch --tags' from Wordpress directory, then 'git checkout <version>' and 'git submodule update wordpress' from main folder
* _Staging_
- Modify config/deploy/staging.rb file with needed information
- Run 'cap delpoy:setup'
- SSH into the server and change the shared wp-config.staging.php with needed database information
- Run 'cap deploy'
* _Production_
- Same as for staging, but production files are involved

TODO:
----

* Incorporate h5bp ant build script via Capistrano


Note about submodules:

> To update each submodule, you could invoke the following command. (At root of repo.)

>> git submodule -q foreach git pull -q origin master

> You can remove the -q option to follow the whole process.