# aes-command-line

This is simple command line scripts for file encryption/decryption.

It is just two tiny shell scripts, that call **openssl enc** using symmetric cipher AES-256 in CBC mode.


## Deprecation Notice 

> There are a number of problems with key derivation in OpenSSL: only newer versions 
> support PBKDF2 and modern hashing functions. 
>
> LibreSSL 2.8.3 on macOS Catalina — does not support this as of August 2020. 
> 
> Moreover, the file format of encrypted files is not versioned and does not contain information about 
> key derivation, hash function or number of interations. 
> 
> This is not the thing I would like to fix in a shell script. 
> 
> Seek other encryption tools, for example: https://age-encryption.org/ 
> 
> If you still want to use this — read comment about CRYPTO_ARGS variable in `aes-encrypt.sh`
>
> The defaults (`-md md5`) there are for compatiblity with older versions of OpenSSL and are not secure at all. 


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
