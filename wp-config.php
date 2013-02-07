<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */
 
/** Wordpress custom paths settings (wordpress is located in the sub-dir) **/
define('WP_SITEURL', 'http://' . $_SERVER['SERVER_NAME'] . '/wordpress');
define('WP_HOME',    'http://' . $_SERVER['SERVER_NAME']);
 
/** Wordpress custom content directory **/ 
define('WP_CONTENT_DIR', $_SERVER['DOCUMENT_ROOT'] . 'wp-content');
define('WP_CONTENT_URL', 'http://' . $_SERVER['SERVER_NAME'] . '/wp-content');
 
/** Wordpress default theme **/
define('WP_DEFAULT_THEME', 'wp_default');


/** Environments settings **/
if ( file_exists( dirname( __FILE__ ) . '/wp-config.local.php' ) ) {

    // Local Environment
    define('ENVIRONMENT', 'local');
    define('WP_DEBUG', true);

    require( 'wp-config.local.php' );

} elseif ( file_exists( dirname( __FILE__ ) . '/wp-config.staging.php' ) ) {

    // Playground Environment
    define('ENVIRONMENT', 'staging');
    define('WP_DEBUG', true);

    require( 'wp-config.staging.php' );

} elseif ( file_exists( dirname( __FILE__ ) . '/wp-config.production.php' ) ) {

    // Production Environment
    define('ENVIRONMENT', 'production');
    define('WP_DEBUG', false);

    require( 'wp-config.production.php' );
}

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

/**#@-*/

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
