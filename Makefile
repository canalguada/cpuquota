DESTDIR :=
prefix  := /usr/local
bindir  := ${prefix}/bin
userdir  := /etc/systemd/user
QUOTAS	= 8 16 25 33 50 66 75 

.PHONY: install
install: 
	install -d ${DESTDIR}${bindir}
	install -m755 CpuNN ${DESTDIR}${bindir}/
	$(foreach quota,$(QUOTAS),ln -sf -T CpuNN ${DESTDIR}${bindir}/Cpu$(quota);)
	install -d ${DESTDIR}${userdir}
	$(foreach quota,$(QUOTAS),echo "[Slice]\nCPUQuota=$(quota)%\n" > ${DESTDIR}${userdir}/cpu$(quota).slice;)

.PHONY: uninstall
uninstall:
	rm -f ${DESTDIR}${bindir}/CpuNN
	$(foreach quota,$(QUOTAS),rm -f ${DESTDIR}${bindir}/Cpu$(quota);)
	$(foreach quota,$(QUOTAS),rm ${DESTDIR}${userdir}/cpu$(quota).slice;)
