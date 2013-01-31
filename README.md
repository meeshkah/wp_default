Default Wordpress installation
------------------------------

Clean Wordpress repository with essential plugins

This is based on the examples given in this article http://davidwinter.me/articles/2012/04/09/install-and-manage-wordpress-with-git/

TODO:
----

* Incorporate h5bp ant build script
* Write custom deploy script


Note about submodules:

> To update each submodule, you could invoke the following command. (At root of repo.)

>> git submodule -q foreach git pull -q origin master

> You can remove the -q option to follow the whole process.