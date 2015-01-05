# Not so shitty

### Build

```bash
# Install npm + bower dependencies and then build
npm install
# Launch the watcher & servers
npm run start:all
# Lauch servers only
npm run start:server
# http://localhost:8000
```

### Fucking BDC how does it work ?

In assets/bdc-config.json set boardId and stuff that's needed

In app, changes are stored in local storage, to persist, copy and paste conf
`(click "view conf" button you fool)`



### Tests lol

```bash
# Unit tests - Karma + mocha + chai
npm run test:unit

# Functional tests - Protractor + chai + cucumber
# Available options:
# HOST     -> http://localhost:8000
# BROWSER  -> chrome | firefox | phantomjs
# SELENIUM -> http://127.0.0.1:4444/wd/hub
# You need specify a selenium server or to install one with!
# Local server must be launched: npm start &
node_modules/.bin/webdriver-manager update
HOST=http://localhost:8000 BROWSER=chrome npm run test:functional
npm run test:functional
```

### Submodules pas besoin ?

```
git submodule foreach git pull origin master
```

### Livereload prout

[Chrome extention](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)

### Documentation lol

    # Generate docs using dgeni
    npm run docs
