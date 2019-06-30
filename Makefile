
.PHONY: install clean

all : mybar.service

mybar.service: mybar.service.mk
	sh mybar.service.mk > mybar.service

install : mybar.sh mybar.service
	chmod 755 mybar.sh
	cp mybar.sh        ${HOME}/.local/bin
	cp mybar.service   ${HOME}/.config/systemd/user

clean :
	@if [ -f mybar.service ] ; then rm mybar.service ; echo cleaned ; else echo nothing to do ; fi

uninstall:
	rm ${HOME}/.local/bin/mybar.sh
	rm ${HOME}/.config/user/mybar.service

