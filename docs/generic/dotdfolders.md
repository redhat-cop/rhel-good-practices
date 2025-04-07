# *.d configuration folders

Most system services and applications rely on configuration files for their settings and many packages come with pre-populated files (usually *.conf) with all defaults that can be edited and tailored based on your needs.

Editing the main .conf file can introduce challenges including:

- The main configuration file could be overwritten during updates/upgrades
- The main configuration file can change significantly from the default, making it difficult to read and interpret

*.d folders come to the rescue for both scenarios.

Many applications include specific folders, with ".d" in their name (i.e. *conf.d*, *conf.modules.d*) that contain:

- **Configuration snippets** -> Chunks of the main config file with only specific overrides
- **Modular configurations** -> Dedicated configuration files for specific functionalities
- **How to use them** -> Syntax, flags to be enabled/disabled in the application to load files in the directory, etc.

It is a good practice to use them to immediately benefit from:

- Better readability
- Modular approach
- Persistence across application or OS updates/upgrades

## Example - httpd

Let's take **httpd** as an example.

By quickly inspecting its main folder, **/etc/httpd/conf/**, we can see that it has three configuration folders:

```bash
ls /etc/httpd/conf*
/etc/httpd/conf:
httpd.conf  magic

/etc/httpd/conf.d:
autoindex.conf  mod_dnssd.conf  README  userdir.conf  welcome.conf

/etc/httpd/conf.modules.d:
00-base.conf    00-dav.conf  00-mpm.conf       00-proxy.conf    01-cgi.conf  10-mod_dnssd.conf  README
00-brotli.conf  00-lua.conf  00-optional.conf  00-systemd.conf  10-h2.conf   10-proxy_h2.conf
```

Its main configuration file, **httpd.conf** stored in */etc/httpd/conf/* folder contains all the default configuration settings for a standard webserver to start and be operative.

??? info "Extract from httpd.conf file"
    ```
    #
    # This is the main Apache HTTP server configuration file.  It contains the
    # configuration directives that give the server its instructions.
    # See <URL:http://httpd.apache.org/docs/2.4/> for detailed information.
    # In particular, see
    # <URL:http://httpd.apache.org/docs/2.4/mod/directives.html>
    # for a discussion of each configuration directive.
    #
    # See the httpd.conf(5) man page for more information on this configuration,
    # and httpd.service(8) on using and configuring the httpd service.
    #
    # Do NOT simply read the instructions in here without understanding
    # what they do.  They're here only as hints or reminders.  If you are unsure
    # consult the online docs. You have been warned.
    #
    # Configuration and logfile names: If the filenames you specify for many
    # of the server's control files begin with "/" (or "drive:/" for Win32), the
    # server will use that explicit path.  If the filenames do *not* begin
    # with "/", the value of ServerRoot is prepended -- so 'log/access_log'
    # with ServerRoot set to '/www' will be interpreted by the
    # server as '/www/log/access_log', where as '/log/access_log' will be
    # interpreted as '/log/access_log'.

    #
    # ServerRoot: The top of the directory tree under which the server's
    # configuration, error, and log files are kept.
    #
    # Do not add a slash at the end of the directory path.  If you point
    # ServerRoot at a non-local disk, be sure to specify a local disk on the
    # Mutex directive, if file-based mutexes are used.  If you wish to share the
    # same ServerRoot for multiple httpd daemons, you will need to change at
    # least PidFile.
    #
    ServerRoot "/etc/httpd"

    #
    # Listen: Allows you to bind Apache to specific IP addresses and/or
    # ports, instead of the default. See also the <VirtualHost>
    # directive.
    #
    # Change this to Listen on a specific IP address, but note that if
    # httpd.service is enabled to run at boot time, the address may not be
    # available when the service starts.  See the httpd.service(8) man
    # page for more information.
    #
    #Listen 12.34.56.78:80
    Listen 80
    [...]
    # Dynamic Shared Object (DSO) Support
    #
    # To be able to use the functionality of a module which was built as a DSO you
    # have to place corresponding `LoadModule' lines at this location so the
    # directives contained in it are actually available _before_ they are used.
    # Statically compiled modules (those listed by `httpd -l') do not need
    # to be loaded here.
    #
    # Example:
    # LoadModule foo_module modules/mod_foo.so
    #
    Include conf.modules.d/*.conf
    [...]
    # Supplemental configuration
    #
    # Load config files in the "/etc/httpd/conf.d" directory, if any.
    IncludeOptional conf.d/*.conf
    ```

By carefully reviewing the *httpd.conf* file, we can see that there are two specific directives, **"Include conf.modules.d/*.conf"** and **"IncludeOptional conf.d/*.conf"** that are looking for *.conf files in the *.d folders.

Each of these files contain specific configuration, either for the application or modules (i.e. SSL/TLS), and it is an accurate example of how configuration files can be well organized using **.d folders**.

### Adding a custom configuration

An admin could edit the webserver configuration, to create a virtual host for **example.net**.
To do so, it is enough to create a new file, in the *conf.d* folder, named **example-net.conf** with the following content:

??? info "Example custom configuration - example-net.conf"
    ```
    # This is example config file for virtual host "example.net"

    # Redirect only vhost. Use permanent url for same resource.
    #<VirtualHost *:80>
    #	ServerAlias example.net
    #	RedirectPermanent / http://www.example.net
    #</VirtualHost>

    <VirtualHost *:80>
    	ServerName www.example.net
    	ServerAdmin webmaster@example.net
    	DocumentRoot /home/services/httpd/vhosts/example.net
    	ErrorLog logs/example.net-error_log
    	TransferLog logs/example.net-access_log
    </VirtualHost>

    #<Directory "/home/services/httpd/vhosts/example.net">
    #  AllowOverride None
    #  Options None
    #  <IfModule mod_authz_host.c>
    #    Require all granted
    #  </IfModule>
    #</Directory>
    ```

Any change made to the **conf.d** and **conf.modules.d** can be made effective by reloading the *httpd* service, so to apply the new virtual host:

```bash
systemctl restart httpd
```
