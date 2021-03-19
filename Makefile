ARCHS=armv7 arm64

CFLAGS+=-I.
CFLAGS+=-Wall

SOURCES=main.m
EXEC=pl

# iOS
IOS_ARCHS=$(addprefix -arch ,$(ARCHS))
IOS_CFLAGS+=$(IOS_ARCHS)
IOS_SYSROOT=$(shell xcrun --sdk iphoneos --show-sdk-path)
IOS_CFLAGS+=-isysroot ${IOS_SYSROOT}
IOS_CFLAGS+=-fembed-bitcode
IOS_CFLAGS+=-flto
IOS_CFLAGS+=-O3 -Wall
IOS_CC=$(shell xcrun --sdk iphoneos --find clang) $(IOS_CFLAGS)

ios:
	$(IOS_CC) $(CFLAGS) -DTARGET_IOS=1 -o $(EXEC) $(SOURCES) \
		-fmodules
	xcrun --sdk iphoneos strip $(EXEC)
	xcrun --sdk iphoneos codesign -f --entitlements ./entitlements.plist -s- $(EXEC)
	ldid2 -Sentitlements.plist $(EXEC)

