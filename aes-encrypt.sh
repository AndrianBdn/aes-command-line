#!/bin/bash

CIPHER="aes-256-cbc"
CRYPTO_ARGS="-md md5"
# "-md md5" is compatibility option to decrypt old files  
#
# on a newer version of OpenSSL change this to "-md sha512 -pbkdf2 -iter 200000" to encrypt new files 
# or better - read a deprecation notice in README.md and stop using this. 

SCRIPT=`basename $0`
SCRIPT=${SCRIPT%.sh}
SRM_CMD=rm

command -v openssl >/dev/null 2>&1 || { echo "Could not find openssl in path"; exit 1; }
command -v $SRM_CMD >/dev/null 2>&1 || SRM=shred;
command -v $SRM_CMD >/dev/null 2>&1 || { echo "Could not find 'srm' or 'shred' for secure deletion"; exit 1; }


function ctrl_c() {
        echo "** Trapped CTRL-C"
        clear # clear screen 
        printf '\e]50;ClearScrollback\a' # clear iTerm scroll back https://superuser.com/questions/576410/how-can-i-partially-clear-my-terminal-scrollback
        exit 1
}


if [ $# -ne 1 ]
then
  echo "Usage: $0 <file>"
  exit 1
fi

if test -r "$1" -a -f "$1"
then
  cd `dirname $1`

  case "$SCRIPT" in 

    "aes-encrypt")
      openssl $CIPHER $CRYPTO_ARGS -salt -in $1 -out $1.aes
      if [ $? -eq 0 ]
      then
        echo "- created $1.aes in $(pwd)"
        echo "- securely deleting using $SRM_CMD"
        $SRM_CMD $1
        echo "- original file $1 deleted"
      else
        echo "- encryption failed, file is still there"
      fi
    ;;

    "aes-decrypt")

      out=${1%.aes}
      if [ "$1" != "$out.aes" ]
      then
          echo "- $SCRIPT argument should contain .aes extension"
          exit 1
      fi
        
      openssl $CIPHER $CRYPTO_ARGS -salt -d -in $1 -out $out
      if [ $? -eq 0 ]
      then
        echo "- decrypted $out in $(pwd)"
        rm $1
        echo "- deleted $1"
      fi
    ;;

    "aes-view")
      trap ctrl_c INT

      out=${1%.aes}
      if [ "$1" != "$out.aes" ]
      then
          echo "- $SCRIPT argument should contain .aes extension"
          exit 1
      fi

      openssl $CIPHER $CRYPTO_ARGS -salt -d -in $1 
      sleep 7200

    ;;

  esac


else
  echo "- file $1 does not exists"
  exit 1
fi
