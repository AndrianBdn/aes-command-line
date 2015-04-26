# aes-command-line

This is simple command line scripts for file encryption/decryption.

It is just two tiny shell scripts, that call **openssl enc** using symmetric cipher AES-256 in CBC mode.

## Usage


#### # aes-encrypt &lt;file&gt;

- encrypts file using **aes-256-cbc** with salt
- write the result to <file>.aes in the same directory
- delete original file


#### # aes-encrypt &lt;file&gt;.aes

- decrypts file encrypted with **aes-encrypt**
- write the result to <file> (without aes extension) in the same directory
- delete encrypted file

## Installation

#### run "sh install.sh"

- will copy scripts as "aes-encrypt" and "aes-decrypt" to /usr/local/bin
- use DESTDIR environment variable for other locations
- To install to your home directory bin use

<tt>DESTDIR=~ sh install.sh</tt>


## Tests

- Uses OpenSSL, as secure as **aes-256-cbc**
- Works on Mac
