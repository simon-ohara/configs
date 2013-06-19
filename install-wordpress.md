## Installing WordPress Manually

### Before starting
1. I already had MySQL set up and installed.
* XCode already installed
* Editing files using vim

### Set up Apache with PHP on Mountain Lion
Taken from: https://discussions.apple.com/docs/DOC-3083

### Download and Configure WordPress
````bash
cd ~/Sites
curl http://wordpress.org/latest.tar.gz | tar zx
````

Rename the wordpress directory
````bash
mv wordpress/ wptest/
````

Configure
````bash
mv wptest/wp-config-sample.php wptest/wp-config.php
vim wptest/wp-config.php
````

````php
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wptest');

/** MySQL database username */
define('DB_USER', 'wpuser');

/** MySQL database password */
define('DB_PASSWORD', 'password321');

/** MySQL hostname */
define('DB_HOST', '127.0.0.1');
````







