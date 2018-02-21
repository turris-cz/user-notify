.SUFFIXES: .mo .po

LANGS=$(shell ls po/*/user-notify.po)
MLANGS=$(LANGS:.po=.mo)
SCRIPTS=$(filter-out %.config %.cron README, $(shell ls src/scripts/*))

all: $(MLANGS)

update-langs:
	$(foreach lang, $(LANGS), msgmerge --update $(lang) po/user-notify.pot)

.po.mo:
	msgfmt --output-file=$@ $<

install: install_langs install_scripts install_aux

install_aux:
	install -D src/user_notify.cron $(DESTDIR)/etc/cron.d/user_notify.cron
	install -D src/user_notify.config $(DESTDIR)/etc/config/user_notify

install_scripts:
	install -d $(DESTDIR)/usr/bin
	install $(SCRIPTS) $(DESTDIR)/usr/bin

install_langs: $(MLANGS)
	$(foreach mlang, $(MLANGS), \
	install -D $(mlang) $(DESTDIR)/usr/share/locale/$(patsubst po/%/user-notify.mo,%/LC_MESSAGES/user-notify.mo,$(mlang));\
	)
