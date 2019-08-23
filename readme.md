# Chowdown

A simple, plaintext recipe database for hackers powered by [Jekyll](https://jekyllrb.com/)

Forked from [http://clarklab.github.io/chowdown](http://clarklab.github.io/chowdown).

You've just stumbled into **Chowdown**, a plain text recipe database for hackers. Over the years, I've tried dozens of recipe apps and services in an attempt to eat better and get more organized. With each app came a new format and <em>recipe lock-in</em>, neither of which got me excited.

**Chowdown** is my attempt at extending [Clarklab's](https://github.com/clarklab) excellent work at fixing recipe app burnout, by moving my recipes out of closed services and into plain text. For example, here's [a recipe in plain text][1] that I found online, and then added to the repo.

[Here's that same recipe processed with **Chowdown**.][2] It's a simple layout with a photo, ingredient list, and directions.

The magic comes behind-the-scenes, with [recipe microdata via schema.org][3]. This process adds special tags around each bit of content, which is what let's other apps (list coming soon) read your recipes. Data portability! Jekyll is used to then process the recipes, images, and other static files to generate a static website that can be hosted anywhere. 

**Chowdown** is definitely a work in progress. Active development is taking place. I'm new to Jekyll. Things might break. The recipes, however, are here to stay.
  
Go cook something rad,  
    Sean  
    [@\_seanlane][4]  

[1]:https://raw.githubusercontent.com/seanlane/chowdown/master/_recipes/pepperoncini-pork.md
[2]:http://recipes.lane.sh/recipes/pepperoncini-pork.html
[3]:http://schema.org/Recipe
[4]:http://twitter.com/_seanlane

## Installing

This project uses the bundler gem to install all the dependencies.

Inital setup (if needed):

* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Install RubyGems](https://rubygems.org/pages/download)
* Install bundler: `$ gem install bundler`

Then run `bundler install` to get all the dependencies. Finally, to get a demo version of the project up and running, run `jekyll serve` from the root directory of the project and it will give a local address from which you can view the generated website in your browser (probably [127.0.0.1:4000](http://127.0.0.1:4000)). FYI, it may take up to 15-30 seconds for the site to be generated, depending on your computer. Probably less than 10 though.

## Configuration

Modify the `_config.yml` file as needed. You'll probably just need to change  the `title`, `email`, `twitter_username`, and `github_username` fields to initially get going.

## Add recipes

Add recipes to the `_recipes` directory, using other recipe files as an example. Most of the fields are optional , though I'm not sure which ones will break the site if you don't add them. As long as it has at least a title, you're probably fine, though the recipe won't be very useful without ingredients or directions. To add an image, save the image you'd like to use in the `images/_original` directory, and then add the image filename to the `image` field in the recipe file. This tells the static site generator that you want to use that image for this recipe.

## Deploying the website with GitHub pages

~~I use the `Makefile` in this website to build the site, and then move the generated site files to a webhost. You can do something similar, if you have one, or you could also host the site for free on [GitHub Pages](https://pages.github.com).~~

I've since moved the site to be hosted via [GitHub Pages](https://pages.github.com), using the modified Makefile in the project. Following the instructions here (https://stackoverflow.com/a/35798092), the Makefile pushes the changes onto the `gh-pages` branch to be served by GitHub. Change the CNAME file to your domain, set the DNS records as described in the GitHub Pages documentation, and then enjoy.

## Deploying the website on your own web server with systemd

EDIT: Further instructions on installing this to run on Ubuntu 18.04 can be found on the following page: [Instructions for setting up on Ubuntu 18.04](https://github.com/seanlane/chowdown/blob/master/setup-ubuntu18.04.md)

This section was provided by Josh at linuxhelp.sytes.net, who is hosting an instance of this project on private webserver.

**NOTE:** _All instructions are written for and have been tested on only an Ubuntu 16.04 server. They may or may not work on other linux distributions._

```
[Unit]
Description=Start jekyll

[Service]
Type=simple
WorkingDirectory=/var/www/chowdown
ExecStart=/usr/local/bin/jekyll build --watch 
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
User=root
Group=root

[Install]
WantedBy=multi-user.target
```

Create this script and save it into `/etc/systemd/system/jekyll.service`. Edit any fields that are required such as `User`, `Group`, `WorkingDirectory`.

Then in the command line enter the following commands 

```
sudo systemctl daemon-reload
sudo systemctl enable --now jekyll.service
```

Note that using enable --now is the same as running

```
sudo systemctl start jekyll.service
sudo systemctl enable jekyll.service
```

After the service is started you should see an output saying that a link was created. eg. "ln -s ...etc..."

Now in regards to whether a daemon is needed or even useful. I think that in my situation where I'm directly hosting the website on my physical Ubuntu server it has the effect of displaying the changes I make to the files in the chowdown directory immediately without the need to run jekyll build. This can be useful but it's also dangerous. I don't have a testing folder to make changes, test, and then move to live. I may implement such a folder soon. The advantage would then be viewing the localhost "testing" version changes without running the build command at every change. Then moving the finished and tested files to the live directory. The second use case makes sense for hosting it at github too. The advantage is only not having to run the jekyll build command.
