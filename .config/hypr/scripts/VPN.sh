#!/usr/bin/env zsh

VPN="https://anyconnect.vught.nl"

if [[ $(pgrep openconnect) ]]; then
	pkill openconnect
else
	openconnect-sso --server $VPN
fi
