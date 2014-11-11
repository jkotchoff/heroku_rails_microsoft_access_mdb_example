heroku_rails_microsoft_access_mdb_example
=========================================

Read a Microsoft Access .mdb file in a heroku rails app

##TODO

Look into using
[https://github.com/profit-strategies/heroku-buildpack-mdbtools.git#769168ff5f5f3087c040a4b35da4afda06be7ce1](https://github.com/profit-strategies/heroku-buildpack-mdbtools.git#769168ff5f5f3087c040a4b35da4afda06be7ce1)

to make this work on heroku as per
[https://github.com/heroku/heroku-buildpacks](https://github.com/heroku/heroku-buildpacks)

hmm, looks like there's a working fork according to [https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/issues/1](https://github.com/jkotchoff/heroku_rails_microsoft_access_mdb_example/issues/1). let's try this by first deploying the rails app and then running:
```
heroku config:set BUILDPACK_URL=https://github.com/Ignitewithus/heroku-buildpack-mdbtools.git\#242c5c24878f84d8747c48f7aca8f5444b261d97
```