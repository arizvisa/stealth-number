#!/usr/bin/env bash
VC_VERSION=14.0
PSDK_VERSION=10.0.17134.0

VC_INCLUDES="${ProgramFiles_x86_}/Microsoft Visual Studio $VC_VERSION/VC/include;"
PSDK="${ProgramFiles_x86_}/Windows Kits/`cut -d. -f1 <<<"$PSDK_VERSION"`/Include"

PSDK_INCLUDES=
for n in ucrt um shared; do
    PSDK_INCLUDES+="${PSDK}/${PSDK_VERSION}/$n;"
done

OPENSSL_DIR="${HOME}/build/openssl"
OPENSSL_LIBDIR="${OPENSSL_DIR}/out32"
OPENSSL_LIBS="-llibcrypto -lzlib"

PSDK_LIBS="-llibvcruntime -lws2_32 -lkernel32 -lcrypt32 -luser32 -ladvapi32 -lshlwapi"

CFLAGS="-target i686-pc-windows-msvc"
LDFLAGS="-target i686-pc-windows-msvc -static"

CXX=clang++ DEFS="$CFLAGS" LD=clang++ LDFLAGS="$LDFLAGS $OPENSSL_LIBS $PSDK_LIBS" INCLUDE="$VC_INCLUDES;$PSDK_INCLUDES" INC="-I$OPENSSL_DIR/include" LIBS="-L$OPENSSL_DIR $OPENSSL_LIBS" make
