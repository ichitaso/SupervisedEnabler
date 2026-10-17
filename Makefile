DEBUG = 0
FINALPACKAGE = 1

ARCHS = arm64

THEOS_DEVICE_IP = localhost -p 2222

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
TARGET = iphone:16.5:15.0
else ifeq ($(THEOS_PACKAGE_SCHEME),roothide)
TARGET = iphone:16.5:15.0
else
export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/
TARGET = iphone:14.5:11.0
endif

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
