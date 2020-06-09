#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cp "$DIR"/../smb2imm/sys/main.dol "$DIR"/../smb2mut/sys
"$DIR"/../util/ppc-inject/PPCInject "$DIR"/../smb2imm/files/mkb2.main_loop.rel "$DIR"/../smb2mut/files/mkb2.main_loop.rel "$DIR"/iw.asm
# "$DIR"/../util/ppc-inject/PPCInject "$DIR"/../smb2imm/files/mkb2.main_game.rel "$DIR"/../smb2mut/files/mkb2.main_game.rel "$DIR"/main_game.asm
