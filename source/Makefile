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

# Version: 2.7
# Run this makefile preceed  by sudo command !!!!!!!
# BUILD = "../package_name-version" given from "debianizador" app

BUILD = 
CONFIG_PATH = /etc
BIN_PATH = /usr/bin
SYSTEMD_PATH = /systemd/user
UDEV_PATH = /udev/rules.d
PROFILE_PATH = /profile.d

test:
	@ echo User: $(USER)


pw_config:
	@ echo "install: pw_config "
	@ echo $(BUILD)$(CONFIG_PATH)/pipewire
	@ mkdir -p $(BUILD)$(CONFIG_PATH)/pipewire
	@ cp -R ./pipewire/*     $(BUILD)$(CONFIG_PATH)/pipewire/
	@ echo


wp_config:
	@ echo "install: wp_config "
	@ echo $(BUILD)$(CONFIG_PATH)/wireplumber
	@ mkdir -p $(BUILD)$(CONFIG_PATH)/wireplumber
	@ cp -R ./wireplumber/*     $(BUILD)$(CONFIG_PATH)/wireplumber/
	@ echo


systemd_services:
	@ echo "install: systemd_services "
	@ echo $(BUILD)$(CONFIG_PATH)/systemd/user
	@ mkdir -p $(BUILD)$(CONFIG_PATH)/systemd/user
	@ cp -R ./systemd/user/* $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/
	@ echo


udev_rules:
	@ echo "install: udev_rules "
	@ echo $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)
	@ mkdir -p $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)
	@ cp .$(UDEV_PATH)/* $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/
	@ echo

profile:
	@ echo "install: profile files "
	@ echo $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)
	@ mkdir -p $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)
	@ cp .$(PROFILE_PATH)/* $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)/
	@ echo

binary:
	@ echo "install: binary "
	@ echo $(BUILD)$(BIN_PATH)/
	@ mkdir -p $(BUILD)$(BIN_PATH)
	@ cp -R ./bin/* $(BUILD)$(BIN_PATH)/
	@ echo

	
install: test pw_config wp_config systemd_services udev_rules profile binary 



uninstall: test
ifeq ($(USER),root)
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
	@ for N in $$( ls ./wireplumber )  ; do \
		for F in $$( ls ./wireplumber/$${N} ) ; do \
			if [ -f $(BUILD)$(CONFIG_PATH)/wireplumber/$${N}/$${F} ] ; then \
				echo $(BUILD)$(CONFIG_PATH)/wireplumber/$${N}/$${F} && \
				rm $(BUILD)$(CONFIG_PATH)/wireplumber/$${N}/$${F} ; \
			fi ; \
		done \
	done
	@ if [ -f $(BUILD)$(CONFIG_PATH)/wireplumber/env ] ; then \
	    rm -fR $(BUILD)$(CONFIG_PATH)/wireplumber/env && \
	    echo $(BUILD)$(CONFIG_PATH)/wireplumber/env ; \
	    fi 
	@ echo
	@ echo "uninstall: udev rules"
	@ for F in $$( ls ./$(UDEV_PATH) ) ; do \
		if [ -f $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/$${F} ] ; then \
		echo $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/$${F} && \
		rm $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/$${F} ; \
		fi ; \
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
	@ echo "uninstall: profile"
	@ for F in $$( ls ./$(UDEV_PATH) ) ; do \
		if [ -f $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)/$${F} ] ; then \
		echo $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)/$${F} && \
		rm $(BUILD)$(CONFIG_PATH)$(PROFILE_PATH)/$${F} ; \
		fi ; \
	done
	@ echo
	@ echo "uninstall: binaries"
	@ for F in $$( ls ./bin ) ; do \
		if [ -f $(BUILD)$(BIN_PATH)/$${F} ] ; then \
			echo $(BUILD)$(BIN_PATH)/$${F} && \
			rm $(BUILD)$(BIN_PATH)/$${F} ; \
		fi ; \
	done
	@ echo
endif




