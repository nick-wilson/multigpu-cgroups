SCRIPTS_ROOT=pbs-dgx-cgroup-create pbs-dgx-cleanup dgx-cgroup-classify dgx-cgroup-create dgx-cgroup-remove dgx-cgroup-cleanup dgx-docker-cleanup pam-sshd-attach
SCRIPTS_USER=pbs-attach
SCRIPTS_SBIN=pbs-set-interactive
ETC=dgx-cgroup
LIBEXEC=common cgroup-classify cgroup-create cgroup-remove cgroup-cleanup

PREFIX=/usr/local

.PHONY : install
install: $(EXES) $(HELPERS) $(SCRIPTS) $(SCRIPTS_SBIN)
	install -o root -g root -m 0700 -t $(PREFIX)/bin $(SCRIPTS_ROOT)
	install -o root -g root -m 0755 -t $(PREFIX)/bin $(SCRIPTS_USER)
	install -o root -g root -m 0755 -t $(PREFIX)/sbin $(SCRIPTS_SBIN)
	install -o root -g root -m 0755 -d $(PREFIX)/etc $(PREFIX)/libexec/dgx-cgroup
	if [ ! -f $(PREFIX)/etc/$(ETC) ] ; then install -o root -g root -m 0700 -t $(PREFIX)/etc etc/$(ETC) ; fi
	for f in $(LIBEXEC) ; do install -o root -g root -m 0700 -t $(PREFIX)/libexec/dgx-cgroup libexec/$$f ; done
	./pam-config
