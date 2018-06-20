Reading Microsoft Access .mdb files from Ruby on Rails on Heroku
================================================================

# Sample
You can run this rails app and see an .mdb file being accessed on heroku at:

[https://rails-access-mdb-example.herokuapp.com/](https://rails-access-mdb-example.herokuapp.com/)

The code that is running looks like:
```
class HomeController < ApplicationController
  def index
    db = Mdb.open("#{Rails.root.to_s}/lib/microsoft_access_db.mdb")
    output = "Tables: #{db.tables}"
    output += "<br/><br/>"
    output += "Data: #{db[:Balance_Sheet].first}"
    render text: output
  end
end
```

as per [this commit](https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/commit/2264a60e0f51a6eecc44f0f3c2ee1aa20170eca8)

# Overview and configuration

Heroku and OSX have no built-in ODBC drivers to talk to a Microsoft Access .mdb file out of the box.

You can however, use the [mdb gem](https://github.com/concordia-publishing-house/mdb) but in order to do so, you will need [mdb-tools](https://github.com/brianb/mdbtools) working in your environment.

On OSX, getting mdb-tools installed is as easy as:
```
> brew install mdbtools
```

however for Heroku, it's slightly more complicated.

As per [this issue](https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/issues/1), mdbtools can be installed on heroku using [this buildpack](https://github.com/Ignitewithus/heroku-buildpack-mdbtools.git).

However, in order to use a custom buildpack like that in conjunction with rails inside the same heroku app, you need to configure multiple buildpacks.

Enter:
[heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) as per this [blog post](http://www.base2.io/2014/03/14/using-multi-buildpacks-to-deploy-a-yeoman-bower-grunt-application-on-rails)

UPDATE:
Heroku have taken over support of this multi-buildpack. It would be best to now use:
[https://github.com/heroku/heroku-buildpack-multi](https://github.com/heroku/heroku-buildpack-multi)

ie. by associating the heroku-buildpack-multi buildpack to your rails app and adding a .buildpacks configuration [like this](https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/blob/master/.buildpacks), you can deploy a rails app like this normally and then associate the Ignitewithus/heroku-buildpack-mdbtools buildpack afterwards.

ie.
```
> heroku create rails-access-mdb-example
> git push heroku master
> heroku config:set BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-ruby
> touch <somefile>
> git add <somefile>
> git commit
> git push heroku master
```

and
```
.buildpacks
https://github.com/Ignitewithus/heroku-buildpack-mdbtools.git#242c5c24878f84d8747c48f7aca8f5444b261d97
https://github.com/heroku/heroku-buildpack-ruby.git
```

Note that you will perhaps see this error when you build:
```
> status: Unable to connect to system bus: Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or directory
```
however as per [this issue](https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/issues/1), it shouldn't affect anything.


Hope this helps for anyone else out there who needs to talk to an Access database from Rails!
