.SUFFIXES: .mo .po

LANGS=$(shell ls po/*/user-notify.po)
MLANGS=$(LANGS:.po=.mo)

all: $(MLANGS)

update-langs:
	$(foreach lang, $(LANGS), msgmerge --update $(lang) po/user-notify.pot)

.po.mo:
	msgfmt --output-file=$@ $<

install: $(MLANGS)
	$(foreach mlang, $(MLANGS), \
	install -D -m 0644 $(mlang) $(DESTDIR)/usr/share/locale/$(patsubst po/%/user-notify.mo,%/LC_MESSAGES/user-notify.mo,$(mlang));\
	)
