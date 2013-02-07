Default Wordpress installation
------------------------------

Clean Wordpress repository with essential plugins and stripped Bones theme

This is based on the examples given in these articles:
* http://theme.fm/2011/08/tutorial-deploying-wordpress-with-capistrano-2082/
* http://theme.fm/2011/09/deploying-wordpress-with-capistrano-part-2-staging-servers-tagging-database-security-2213/
* http://abandon.ie/wordpress-configuration-for-multiple-environments/
* http://davidwinter.me/articles/2012/04/09/install-and-manage-wordpress-with-git/ 

How to
------
* __Prerequisites__
- My strong advice: do all the Ruby related stuff through RVM (https://rvm.io/)
- Capistrano (https://github.com/capistrano/capistrano)
- Railsless-deploy gem (gem install railsless-deploy)
- Latest Git on both local machine and the server (for server-side install read http://ionrails.com/2009/07/15/installing-a-private-git-repository-on-your-shared-hosting-account-bluehost/)
* __Local development__
- Clone the repository into an empty folder
- Initiate submodules by invoking "git submodule update --init --recursive"
- Change the salts in the wp-config.php file (use this link for convenience https://api.wordpress.org/secret-key/1.1/salt/)
- Create wp-config.local.php using the wp-config.default.php template.
- To update Wordpress use 'git fetch --tags' from Wordpress directory, then 'git checkout <version>' and 'git submodule update wordpress' from main folder
- Dont't forget about permissions! (http://stackoverflow.com/questions/2001881/correct-owner-group-permissions-for-apache-2-site-files-folders-under-mac-os-x)
* __Staging__
- Modify config/deploy/staging.rb file with needed information
- Run 'cap delpoy:setup'
- SSH into the server and change the shared wp-config.staging.php with needed database information
- Run 'cap deploy'
* __Production__
- Same as for staging, but production files are involved

TODO:
----

* Database version control
* Incorporate h5bp ant build script via Capistrano