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
TIMEZONE = 'Europe/London'
STATIC_PATHS = ['images','docs']
DISPLAY_CATEGORIES_ON_MENU = False
DELETE_OUTPUT_DIRECTORY = True

# Title menu options
MENUITEMS = [('Archives', '/archives.html'),
             ('Blog', 'http://coding2learn.org'),]

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



PIWIK_URL='www.coding2learn.org/piwik'
# first piwik site is always id 1
PIWIK_SITE_ID=1
