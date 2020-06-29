.SUFFIXES: .mo .po

LANGS=$(shell ls po/*/user-notify.po)
MLANGS=$(LANGS:.po=.mo)
SCRIPTS=$(filter-out %.config %.cron src/scripts/README, $(shell ls src/scripts/*))

all: $(MLANGS)

update-langs:
	$(foreach lang, $(LANGS), msgmerge --update $(lang) po/user-notify.pot)

.po.mo:
	msgfmt --output-file=$@ $<

install: install_langs install_scripts


install_scripts:
	install -d $(DESTDIR)/usr/bin
	install -m 0755 $(SCRIPTS) $(DESTDIR)/usr/bin

install_langs: $(MLANGS)
	$(foreach mlang, $(MLANGS), \
	install -D -m 0644 $(mlang) $(DESTDIR)/usr/share/locale/$(patsubst po/%/user-notify.mo,%/LC_MESSAGES/user-notify.mo,$(mlang));\
	)
