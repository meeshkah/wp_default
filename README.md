Default Wordpress installation
------------------------------

Clean Wordpress repository with essential plugins and stripped Bones theme, running on NGINX (+ APC & Varnish in production), ease of install and deploy with Capistrano.

This is based on the examples given in these articles:
* http://theme.fm/2011/08/tutorial-deploying-wordpress-with-capistrano-2082/
* http://theme.fm/2011/09/deploying-wordpress-with-capistrano-part-2-staging-servers-tagging-database-security-2213/
* http://abandon.ie/wordpress-configuration-for-multiple-environments/
* http://davidwinter.me/articles/2012/04/09/install-and-manage-wordpress-with-git/ 

How to
------

### Prerequisites ###
- RVM (https://rvm.io/)
- Latest Git on both local machine and the server (for server-side install read http://ionrails.com/2009/07/15/installing-a-private-git-repository-on-your-shared-hosting-account-bluehost/)
- NGINX

### Local development ###
- Clone the repository into an empty folder
- Change the origin of the repository, i.e. 
		git remote rename origin temp
		git remote add origin <repo_address>
		git remote rm temp
- Initiate submodules by invoking ```git submodule update --init --recursive```
- Run 'bundle install' from the project folder
- Change the salts in the wp-config.php file (use this link for convenience https://api.wordpress.org/secret-key/1.1/salt/)
- Create wp-config.local.php using the wp-config.default.php template.
- To update Wordpress use 'git fetch --tags' from Wordpress directory, then 'git checkout <version>','cd ..', 'git add -A' and commit
- Dont't forget about permissions!

### Staging ###
- Modify config/deploy/staging.rb file with needed information
- Run 'cap delpoy:setup'
- SSH into the server and change the shared wp-config.staging.php with needed database information
- Run 'cap deploy'

### Production ###
- Same as for staging, but production files are involved

TODO
----

* [ ] Full Capistrano install and deploy for both staging and production
* [ ] Database version control