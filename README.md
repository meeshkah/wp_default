Default Wordpress installation
------------------------------

Clean Wordpress repository with essential plugins

This is based on the examples given in this article http://davidwinter.me/articles/2012/04/09/install-and-manage-wordpress-with-git/

How to
------

* _Local development_
- Clone the repository into an empty folder
- Initiate submodules by invoking "git submodules update --init --recursive"
- Change the salts in the wp-config.php file (use this link for convenience https://api.wordpress.org/secret-key/1.1/salt/)
- Create wp-config.local.php using the wp-config.default.php template.
* _Staging_
- Modify config/deploy/staging.rb file with needed information
- SSH into the server and change the shared wp-config.staging.php with needed database information
* _Production_
- Same as for staging, but production files are involved

TODO:
----

* Incorporate h5bp ant build script via Capistrano


Note about submodules:

> To update each submodule, you could invoke the following command. (At root of repo.)

>> git submodule -q foreach git pull -q origin master

> You can remove the -q option to follow the whole process.