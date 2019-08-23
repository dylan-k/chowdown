## Ubuntu 18.04 installation instructions.
### Author: Josh Pickard; linuxhelp.sytes.net

---

In order for chowdown to work we'll need jekyll, a static site generator, to generate the site. Before that we need to setup the dependencies. Of course it's best to insure we're up to date.

```
sudo apt update && sudo apt upgrade
```
Now for a few dependencies.

```
sudo apt install ruby ruby-dev build-essential
```

It is considered best practice not to run ruby or ruby gems as root. So we'll set up a specific environment for our non root user<br>

```
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME=$HOME/gems' >> ~/.bashrc
echo 'export PATH=$HOME/gems/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```
Installing jekyll

```
gem install jekyll bundler
```

If you get an error installing bundler try installing `bundle`. Once again insure we're up to date

```
gem update --system
gem update jekyll
```

Now that jekyll is installed and ready you go into the directory you want to run chowdown in.<br>

```
cd /var/www
```

We can pull chowdown from github.

```
git clone https://github.com/seanlane/chowdown.git
```

For me I use a different user than root when hosting webpages. <br>

```
sudo chown -R $USER:$USER chowdown
cd chowdown
```

To finalize installing and preparing chowdown

```
bundler install
```

Though all instructions and tutorials say `bundler` I had to run

```
bundle install
```

So if you have any issues with it I recommend trying that. Modify the `_config.yml` as needed and then run

```
jekyll build
```

The newly created site is in the `_site` folder as `index.html`. I pointed my nginx webserver at this file and created a `jekyll --watch` daemon to actively watch for changes to the website or added recipes. 

To host the site on gh-pages chowdown's readme suggests the instructions [here](https://stackoverflow.com/questions/17835937/how-do-i-push-jekyll-site-directory-to-gh-pages-branch-and-leave-the-source-in/35798092#35798092). For instructions on creating a daemon that will start when your machine starts and actively apply changes or add recipes go to [linuxhelp.sytes.net/daemons.html](http://linuxhelp.sytes.net/daemons.html). Otherwise after any changes or additions run 

```
jekyll build
```

Or you can have it change in real time for a designated period using 

```
jekyll serve
```

I recommend looking through the existing recipes to get an idea for how to add new ones. If you make a copy of an existing recipe template and exchange the information in it for what's required in a new recipe it may be easier to follow.

I believe the syntax is very readable though and I doubt there will be many people with issues once they've made it this far. 

Much credit is due to clarklabs for creating chowdown and to seanlane for making it easier to understand and install.
