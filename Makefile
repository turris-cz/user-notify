.SUFFIXES: .mo .po

LANGS=$(shell ls po/*/user-notify.po)
MLANGS=$(LANGS:.po=.mo)

.PHONY: all
all: $(MLANGS)

.PHONY: update-langs
update-langs:
	$(foreach lang, $(LANGS), msgmerge --update $(lang) po/user-notify.pot)

.po.mo:
	msgfmt --output-file=$@ $<

.PHONY: install
install: $(MLANGS)
	$(foreach mlang, $(MLANGS), \
	install -D -m 0644 $(mlang) $(DESTDIR)/usr/share/locale/$(patsubst po/%/user-notify.mo,%/LC_MESSAGES/user-notify.mo,$(mlang));\
	)
