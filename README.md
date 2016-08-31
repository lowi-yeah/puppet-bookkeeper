Puppet Cassandra module (DSC)
==========================================

[![Build Status](https://secure.travis-ci.org/msimonin/puppet-cassandra.png)](http://travis-ci.org/msimonin/puppet-cassandra)

Overview
--------

Install Apache Cassandra from the [DataStax Community Edition] [1].

[1]: http://planetcassandra.org/


Usage (from the test directory)
--------------------------------

```ruby
node 'seed1' {
  class { 'cassandra':
    cluster_name      => 'testCassandra',
    package_name      => 'cassandra',
    seeds             => [ '192.168.100.2'],
    version           => '2.0.10',
    listen_address    => "192.168.100.2"
  }
}


node 'node1' {
  class { 'cassandra':
    cluster_name   => 'testCassandra',
    package_name   => 'cassandra',
    seeds          => [ '192.168.100.2'],
    version        => '2.0.10',
    listen_address => "192.168.100.3"
  }
}


```


Supported Platforms
-------------------

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 7.0 (Wheezy)

Support
-------

Please create bug reports and feature requests in [GitHub issues] [2].

[2]: https://github.com/msimonin/puppet-cassandra/issues


License
-------

Copyright (c) 2012-2013 smarchive GmbH, 2013 Gini GmbH

This script is licensed under the [Apache License, Version 2.0] [3].

[3]: http://www.apache.org/licenses/LICENSE-2.0.html
