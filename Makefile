SUBDIRS := $(wildcard */.)

all: $(SUBDIRS)

$(SUBDIRS):
	echo $@
	$(MAKE) -C $@

deploy:
	for dir in $(SUBDIRS); do \
		echo $$dir ; \
		$(MAKE) -C "$$dir" deploy ; \
	done
pull:
	for dir in $(SUBDIRS); do \
		echo $$dir ; \
		$(MAKE) -C "$$dir" pull ; \
	done

.PHONY: all $(SUBDIRS)
