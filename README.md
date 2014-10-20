env.weechat-irc-im
==================

Easy, modular and self-contained configuration for using weechat for all your IRC and Instant Messaging needs.

This repository contains WeeChat and BitlBee configuration files to enable both programs to work together
and handle all possible messaging needs of a user, supporting the following protocols:

 * Google Talk (via XMPP, OAuth authentication)
 * Facebook Chat (via XMPP, OAuth authentication)
 * MSN (via XMPP)
 * Skype (integration with local-running Skype client)
 * IRC
 * Twitter

It does **not** include any sort of account information.
These are **personal** details and you should add the accounts yourself.
During installation using the `install` script, it will be asked which network/nickname data
you wish to use to connect to the `Freenode` and `OFTC` IRC networks.
Instant messaging account info (Facebook, GTalk, etc.) have to be added by yourself when running
WeeChat/BitlBee for the first time.

