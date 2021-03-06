PN = kodi-standalone-service

PREFIX ?= /usr
INITDIR = $(PREFIX)/lib/systemd/system
USERDIR = $(PREFIX)/lib/sysusers.d
TMPFDIR = $(PREFIX)/lib/tmpfiles.d
POLKDIR = $(PREFIX)/share/polkit-1/rules.d

RM = rm
INSTALL = install -p
INSTALL_DIR = $(INSTALL) -d
INSTALL_PROGRAM = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644
INSTALL_POLK = $(INSTALL_DIR) -m750

common/$(PN):
	@echo -e '\033[1;32mNothing to be done.\033[0m'
	@echo -e '\033[1;32mJust run make install as root.\033[0m'

install-common:
	$(INSTALL_POLK) "$(DESTDIR)$(POLKDIR)"
	$(INSTALL_DATA) polkit/10-kodi.rules "$(DESTDIR)$(POLKDIR)/10-kodi.rules"

install-init:
	$(INSTALL_DIR) "$(DESTDIR)$(INITDIR)"
	$(INSTALL_DIR) "$(DESTDIR)$(USERDIR)"
	$(INSTALL_DIR) "$(DESTDIR)$(TMPFDIR)"
	$(INSTALL_DATA) init/kodi-gbm.service "$(DESTDIR)$(INITDIR)/kodi-gbm.service"
	$(INSTALL_DATA) init/kodi-wayland.service "$(DESTDIR)$(INITDIR)/kodi-wayland.service"
	$(INSTALL_DATA) init/kodi-x11.service "$(DESTDIR)$(INITDIR)/kodi-x11.service"
	$(INSTALL_DATA) init/tmpfiles.conf "$(DESTDIR)$(TMPFDIR)/kodi-standalone.conf"
	$(INSTALL_DATA) init/sysusers.conf "$(DESTDIR)$(USERDIR)/kodi-standalone.conf"

uninstall:
	$(RM) "$(DESTDIR)$(INITDIR)/kodi-gbm.service"
	$(RM) "$(DESTDIR)$(INITDIR)/kodi-wayland.service"
	$(RM) "$(DESTDIR)$(INITDIR)/kodi-x11.service"
	$(RM) "$(DESTDIR)$(TMPFDIR)/kodi-standalone.conf"
	$(RM) "$(DESTDIR)$(USERDIR)/kodi-standalone.conf"
	$(RM) "$(DESTDIR)$(POLKDIR)/10-kodi.rules"

install: install-common install-init

.PHONY: install-common install-init uninstall
