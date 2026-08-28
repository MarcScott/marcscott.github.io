#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Marc Scott'
SITENAME = 'Coding 2 Learn'
SITESUBTITLE = 'Education and Technology Ramblings with a little Politics for good measure.'
SITEURL = ''
RELATIVE_URLS = True
ARTICLE_URL = 'blog/{date:%Y}/{date:%m}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = 'blog/{date:%Y}/{date:%m}/{date:%d}/{slug}/index.html'
PATH = 'content'
THEME = 'themes/pelican-octopress-theme'
# Templates that live outside the theme, so the theme stays as vendored.
THEME_TEMPLATES_OVERRIDES = ['templates']
TIMEZONE = 'Europe/London'
STATIC_PATHS = ['images','docs','tarokka-app']

# tarokka-app is a self-contained app copied through verbatim, not Pelican
# content. Its index.html would otherwise be picked up and rendered as a blog
# post, since Pelican reads .html as an article source.
ARTICLE_EXCLUDES = ['pages','tarokka-app']

# Keep macOS junk out of the built site.
IGNORE_FILES = ['.#*', '.DS_Store']
DISPLAY_CATEGORIES_ON_MENU = False
DELETE_OUTPUT_DIRECTORY = True

# Title menu options
MENUITEMS = [('Archives', '/archives.html'),
             ('Blog', '/index.html'),]

NEWEST_FIRST_ARCHIVES = True


DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_DOMAIN  = SITEURL
#FEED_BURNER = None
#CATEGORY_FEED_ATOM = None
#TRANSLATION_FEED_ATOM = None
FEED_ALL_ATOM = 'feeds/all.atom.xml'
FEED_ALL_RSS = 'feeds/all.rss.xml'

#GITHUB
GITHUB_USER = 'MarcScott'
GITHUB_URL = 'https://github.com/MarcScott'


DEFAULT_PAGINATION = 10

# Static pages
PAGE_PATHS = ['pages']

# Clean page URLs, e.g. /about/
PAGE_URL = '{slug}/'
PAGE_SAVE_AS = '{slug}/index.html'

# Keep pages out of the top nav; we will put them in the sidebar instead.
DISPLAY_PAGES_ON_MENU = False

# Section order on the /recipes/ contents page. Each recipe page sets a
# matching `Group:`; anything with a group not listed here is collected under
# an "Other" heading rather than being dropped.
RECIPE_GROUPS = ['Mains',
                 'Sides & Vegetables',
                 'Sauces & Salsas',
                 'Snacks & Starters',
                 'Puddings',
                 'Spice Blends',]
