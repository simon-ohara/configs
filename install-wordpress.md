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
**NB** It is important to have the `DB_HOST` set to `127.0.0.1` as the term `localhost` makes WP fail to connct to database.


### Create the WordPress Database
Adapted from: http://codex.wordpress.org/Installing_WordPress#Using_the_MySQL_Client
````bash
$ mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 5340 to server version: 3.23.54
 
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
 
mysql> CREATE DATABASE wptest;
Query OK, 1 row affected (0.00 sec)
 
mysql> GRANT ALL PRIVILEGES ON wptest.* TO "wpuser"@"localhost" IDENTIFIED BY "password321";
Query OK, 0 rows affected (0.00 sec)
  
mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.01 sec)

mysql> \q
Bye
$ 
````






