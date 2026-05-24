# ----------------------------------------------------------------------
#
#  Copyright (C) 2013 Juan Ramon Castan Guillen <juanramoncastan@yahoo.es>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
# ----------------------------------------------------------------------

# ###########      pipewire-custom-config Makefile     ###########################
# Version: 3.0.1
# BUILD = "../package-name_version_architecture" given from "debianizador" app

BUILD = 
PREFIX_PATH = /usr/local
SHARE_PATH = /share
BIN_PATH = /usr/bin
CONFIG_PATH = /etc
UDEV_PATH = /udev/rules.d
SYSTEMD_PATH = /systemd/user
WPCONF_PATH = /wireplumber/wireplumber.conf.d
WPSCRIPTS_PATH = /wireplumber/scripts
PW_PATH = /pipewire

test:
	@ echo User: $(USER)


pw_config:
	@ echo "install: pw_config "
	@ echo $(BUILD)$(CONFIG_PATH)$(PW_PATH)
	@ mkdir -p $(BUILD)$(CONFIG_PATH)$(PW_PATH)
	@ cp -R .$(PW_PATH)/*   $(BUILD)$(CONFIG_PATH)$(PW_PATH)
	@ echo


wp_config:
	@ echo -e "install: wp_config "
	@ echo -e $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPCONF_PATH)
	@ echo -e $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPSCRIPTS_PATH)
	@ mkdir -p $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPCONF_PATH)
	@ mkdir -p $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPSCRIPTS_PATH)
	@ cp -R .$(WPCONF_PATH)/*  $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPCONF_PATH)
	@ cp -R .$(WPSCRIPTS_PATH)/*     $(BUILD)$(PREFIX_PATH)$(SHARE_PATH)$(WPSCRIPTS_PATH)
	@ echo


systemd_services:
	@ echo "install: systemd_services "
	@ echo $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)
	@ mkdir -p $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)
	@ cp -R .$(SYSTEMD_PATH)/* $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)
	@ echo


binary:
	@ echo "install: binary "
	@ echo $(BUILD)$(BIN_PATH)/
	@ mkdir -p $(BUILD)$(BIN_PATH)
	@ cp -R ./bin/* $(BUILD)$(BIN_PATH)/
	@ echo

	
install: test pw_config wp_config systemd_services binary 



uninstall: test
	@ echo "uninstall: pipewire custom  config"
	@ for N in $$( ls ./pipewire )  ; do \
		for F in $$( ls ./pipewire/$${N} ) ; do \
			if [ -f $(BUILD)$(CONFIG_PATH)/pipewire/$${N}/$${F} ] ; then \
				echo "$(BUILD)$(CONFIG_PATH)/pipewire/$${N}/$${F}" && \
				rm $(BUILD)$(CONFIG_PATH)/pipewire/$${N}/$${F} ; \
			fi ; \
		done \
	done
	@ echo
	@ echo "uninstall: custom wireplumber config"
	@ for N in $$( ls .$(SHARE_PATH) )  ; do \
		for F in $$( ls .$(SHARE_PATH)/$${N} ) ; do \
			if [ -f $(BUILD)$(SHARE_PATH)/$${N}/$${F} ] ; then \
				echo $(BUILD)$(SHARE_PATH)/$${N}/$${F} && \
				rm $(BUILD)$(SHARE_PATH)/$${N}/$${F} ; \
			fi ; \
		done \
	done
	@ echo
	@ echo "uninstall: systemd service"
	@ for F in $$( ls ./$(SYSTEMD_PATH) ) ; do \
	    if [ -f $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/$${F} ] ; then \
			echo $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/$${F} && \
			rm $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/$${F} ; \
	    fi ; \
	done
	@ echo
	@ echo "uninstall: binaries"
	@ for F in $$( ls .$(BIN_PATH) ) ; do \
		if [ -f $(BUILD)$(BIN_PATH)/$${F} ] ; then \
			echo $(BUILD)$(BIN_PATH)/$${F} && \
			rm $(BUILD)$(BIN_PATH)/$${F} ; \
		fi ; \
	done




