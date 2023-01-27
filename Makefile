DEBUG = 0
GO_EASY_ON_ME := 1
FINALPACKAGE = 1

ARCHS = arm64 arm64e
export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/

THEOS_DEVICE_IP = 192.168.0.13#localhost -p 2222

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
