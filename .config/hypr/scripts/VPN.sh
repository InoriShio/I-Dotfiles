#!/bin/zsh

VPN="https://anyconnect.vught.nl"

if ( pgrep openconnect > /dev/null ); then
    pkill openconnect
else
    openconnect-sso --server $VPN
fi
