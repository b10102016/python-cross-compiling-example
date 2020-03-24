# NDK_URL := https://dl.google.com/android/repository/android-ndk-r16b-linux-x86_64.zip
# NDK_ZIP := $(call download,$(NDK_URL))
# NDK_EXTRACT := $(call extract,$(NDK_ZIP),android-ndk-r16b)
# NDK_STANDALONE := $(WORKING)/ndk-standalone

#################################################################
# Common flags, etc. that can be used in the build
BUILD := x86_64-linux-gnu
HOST := aarch64-linux-gnu
CROSS_PREFIX := $(HOST)-
TOOLCHAIN_BIN := /mnt/ssd/ian-data2/python-cross/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/
CROSS_CC := $(CROSS_PREFIX)gcc
CROSS_CXX := $(CROSS_PREFIX)g++
CROSS_LD := $(CROSS_PREFIX)ld
CROSS_AR := $(CROSS_PREFIX)ar
CROSS_AS := $(CROSS_PREFIX)as
CROSS_RANLIB := $(CROSS_PREFIX)ranlib
CROSS_STRIP := $(CROSS_PREFIX)strip
CROSS_PKG_CONFIG_LIBDIR := $(INSTALL)/usr/lib/aarch64-linux-gnu/pkgconfig/
CROSS_SYSROOT := /mnt/ssd/ian-data2/python-cross/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/aarch64-linux-gnu/libc/
HOST_SYSROOT := $(CROSS_SYSROOT)

CROSS_CPPFLAGS :=
CROSS_CFLAGS :=
CROSS_CXXFLAGS := $(CROSS_CFLAGS)
COMPILE_HOST_PATH := $(TOOLCHAIN_BIN):$(PATH)

CROSS_LDFLAGS := \
	-Wl,-s \
	-L$(INSTALL)/lib




#################################################################
# We need a library of clang builtins
# See https://bugs.llvm.org/show_bug.cgi?id=14469
# COMPILER_RT_DIR := $(TOP)/compiler-rt
# COMPILER_RT_SRC := comparedf2.c mulodi4.c
# COMPILER_RT_OBJDIR := $(WORKING)/compiler-rt
# COMPILER_RT_OBJ := $(addprefix $(COMPILER_RT_OBJDIR)/,$(COMPILER_RT_SRC:.c=.o))
# COMPILER_RT := $(INSTALL)/lib/libcompiler_rt-extras.a

# $(COMPILER_RT_OBJDIR)/%.o: $(COMPILER_RT_DIR)/%.c \
# 		$(TOOLCHAIN_BIN)/$(CROSS_CC) | $(COMPILER_RT_OBJDIR)
# 	$(TOOLCHAIN_BIN)/$(CROSS_CC) -I$(COMPLIER_RT_DIR) -Wall -O2 -c -o $@ $<

# $(COMPILER_RT): $(COMPILER_RT_OBJ) $(TOOLCHAIN_BIN)/$(CROSS_CC)
# 	$(TOOLCHAIN_BIN)/$(CROSS_AR) rcs $@ $(COMPILER_RT_OBJ)

# $(COMPILER_RT_OBJDIR):
# 	mkdir -p $@

# $(INSTALL)/lib/libc++_shared.so: $(TOOLCHAIN_BIN)/$(CROSS_CC) $(make-dirs)
# 	cp -rfd $(NDK_STANDALONE)/$(HOST)/lib/*.so $(INSTALL)/lib


##########################################################################
# Ordering. Add CROSS_CC to PATH for stages that need it.
$(host-toolchain): $(TOOLCHAIN_BIN)/$(CROSS_CC)
# $(host-toolchain): $(INSTALL)/lib/libc++_shared.so
# $(host-toolchain): $(COMPILER_RT)
$(compile-host): export PATH := $(TOOLCHAIN_BIN):$(PATH)
$(compile-host-1): export PATH := $(TOOLCHAIN_BIN):$(PATH)
$(compile-host-2): export PATH := $(TOOLCHAIN_BIN):$(PATH)
