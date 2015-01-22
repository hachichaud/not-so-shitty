# Not so shitty

[The law of shitty dashboards](http://attackwithnumbers.com/the-laws-of-shitty-dashboard)

### Build

```bash
# Install npm + bower dependencies and then build
npm install
# Launch the watcher & livereload
npm start
# http://localhost:8000
```

### Fucking BDC how does it work ?

#### Setup page
- Click 'Setup' button
- Follow link to generate trello key
- Copy-paste trello key
- Choose a board (from select, or copypaste trello board id)
- Press OK
- Drag and drop lists in corresponding slots (dont miss any)
- Choose start and end date and save 'em
- Check at the beginning of the page if everything looks ok, and SAVE

Go to burndown page : yolo

#### If there are issues or weird stuff
Clear local storage, start again

### Nginx minimal conf

```
# in /nginx/sites-available
server {
  root /var/www/not-so-shitty/www;
  index index.html;

  location / {
    try_files $uri /index.html;
  }
}
```

> Note : If you encounter issues with routing, check if `base(href="/")` is in your index.html

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

### Livereload

> (pas besoin ???)

[Chrome extention](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei)

### Documentation lol

    # Generate docs using dgeni
    npm run docs
