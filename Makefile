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

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site         '
	@echo '   make devserver [PORT=8000]       rebuild on save + serve, ctrl-C out'
	@echo '   make serve [PORT=8000]           serve the built site, no rebuilding'
	@echo '   make regenerate                  rebuild on save, no server         '
	@echo '   make clean                       remove the generated files         '
	@echo '   make venv                        just build the .venv, nothing else '
	@echo '                                                                       '
	@echo 'Editing a recipe: run "make devserver", edit content/pages/recipes/,   '
	@echo 'watch http://localhost:8000/recipes/. Commit content/ AND output/ when '
	@echo 'done -- the deploy workflow uploads output/ as-is, it does not build.  '
	@echo '                                                                       '
	@echo 'The first make builds a .venv from requirements.txt automatically.     '
	@echo 'Use "make html" for anything you intend to commit: "make publish" uses '
	@echo 'absolute URLs and would rewrite every page in output/.                 '
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

# Absolute-URL build. Deployment does not use this -- the workflow uploads the
# output/ produced by `make html` -- so running it will rewrite every page.
publish: $(VENVSTAMP)
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

.PHONY: help venv html clean regenerate serve devserver publish
