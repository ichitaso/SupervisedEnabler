DEBUG = 0
GO_EASY_ON_ME = 1
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
ARCHS = arm64 arm64e

TARGET = iphone:13.0:11.0

THEOS_DEVICE_IP = localhost -p 2222

TOOL_NAME = postinst postrm
postinst_FILES = postinst.m
postinst_FRAMEWORKS = UIKit
postinst_INSTALL_PATH = /DEBIAN
postinst_CODESIGN_FLAGS = -Sentitlements.xml
postinst_CFLAGS = -fobjc-arc

postrm_FILES = postrm.m
postrm_FRAMEWORKS = UIKit
postrm_INSTALL_PATH = /DEBIAN
postrm_CODESIGN_FLAGS = -Sentitlements.xml
postrm_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tool.mk

before-package::
	sudo chown -R root:wheel $(THEOS_STAGING_DIR)
	sudo chmod -R 755 $(THEOS_STAGING_DIR)
	sudo chmod 666 $(THEOS_STAGING_DIR)/DEBIAN/control

after-package::
	make clean
	sudo rm -rf .theos/_

