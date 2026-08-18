PY?=python3
VENV?=$(CURDIR)/.venv
VENVSTAMP=$(VENV)/.installed
PELICAN?=$(VENV)/bin/pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

FTP_HOST=localhost
FTP_USER=anonymous
FTP_TARGET_DIR=/

SSH_HOST=ssh.coding2learn.org
SSH_PORT=22
SSH_USER=user_1067344386
SSH_TARGET_DIR=/home/linweb11/c/coding2learn.org/user/htdocs/

S3_BUCKET=my_s3_bucket

CLOUDFILES_USERNAME=my_rackspace_username
CLOUDFILES_API_KEY=my_rackspace_api_key
CLOUDFILES_CONTAINER=my_cloudfiles_container

DROPBOX_DIR=~/Dropbox/Public/

GITHUB_PAGES_BRANCH=gh-pages

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make devserver [PORT=8000]       rebuild on save + serve; ctrl-C out '
	@echo '   make serve [PORT=8000]           serve the built site, no rebuilding '
	@echo '   make clean                       remove the generated files         '
	@echo '   make venv                        just build the .venv, nothing else '
	@echo '                                                                       '
	@echo 'Editing a recipe: run "make devserver", edit content/pages/recipes/,   '
	@echo 'watch http://localhost:8000/recipes/. Commit content/ AND output/ when  '
	@echo 'done -- the deploy workflow uploads output/ as-is, it does not build.   '
	@echo '                                                                       '
	@echo 'The first make builds a .venv from requirements.txt automatically.      '
	@echo 'Use "make html" for anything you intend to commit: "make publish" uses  '
	@echo 'absolute URLs and would rewrite every page in output/.                  '
	@echo '   make ssh_upload                  upload the web site via SSH        '
	@echo '   make rsync_upload                upload the web site via rsync+ssh  '
	@echo '   make dropbox_upload              upload the web site via Dropbox    '
	@echo '   make ftp_upload                  upload the web site via FTP        '
	@echo '   make s3_upload                   upload the web site via S3         '
	@echo '   make cf_upload                   upload the web site via Cloud Files'
	@echo '   make github                      upload the web site via gh-pages   '
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html'
	@echo '                                                                       '

# Everything that runs pelican depends on this stamp, so the virtualenv is
# built on first use and refreshed whenever requirements.txt changes.
$(VENVSTAMP): requirements.txt
	$(PY) -m venv $(VENV)
	$(VENV)/bin/python -m pip install --quiet --upgrade pip
	$(VENV)/bin/python -m pip install --quiet -r requirements.txt
	@touch $@
	@echo 'Build environment ready in $(VENV)'

venv: $(VENVSTAMP)

html: $(VENVSTAMP)
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

regenerate: $(VENVSTAMP)
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve: $(VENVSTAMP)
ifdef PORT
	$(PELICAN) --listen --port $(PORT) -o $(OUTPUTDIR) -s $(CONFFILE)
else
	$(PELICAN) --listen -o $(OUTPUTDIR) -s $(CONFFILE)
endif

devserver: $(VENVSTAMP)
ifdef PORT
	$(PELICAN) -r --listen --port $(PORT) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
else
	$(PELICAN) -r --listen $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

stopserver:
	kill -9 `cat pelican.pid`
	kill -9 `cat srv.pid`
	@echo 'Stopped Pelican and SimpleHTTPServer processes running in background.'

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

ssh_upload: publish
	scp -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: publish
	rsync -e "ssh -p $(SSH_PORT)" -P -rvzc --delete --exclude piwik $(OUTPUTDIR)/ $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR) --cvs-exclude

dropbox_upload: publish
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ftp_upload: publish
	lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "mirror -R $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"

s3_upload: publish
        s3cmd sync $(OUTPUTDIR)/ s3://$(S3_BUCKET) --acl-public --delete-removed --guess-mime-type

cf_upload: publish
	cd $(OUTPUTDIR) && swift -v -A https://auth.api.rackspacecloud.com/v1.0 -U $(CLOUDFILES_USERNAME) -K $(CLOUDFILES_API_KEY) upload -c $(CLOUDFILES_CONTAINER) .

github: publish
	ghp-import -b $(GITHUB_PAGES_BRANCH) $(OUTPUTDIR)
	git push origin $(GITHUB_PAGES_BRANCH)

.PHONY: html help clean regenerate serve devserver publish venv ssh_upload rsync_upload dropbox_upload ftp_upload s3_upload cf_upload github
