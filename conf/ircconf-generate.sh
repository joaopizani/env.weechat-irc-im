#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

USERNAME_DEFAULT="$(whoami)"
read -e -p "Which username you want to use (default = ${USERNAME_DEFAULT}) > " USERNAME_READ
USERNAME="${USERNAME_READ:-"${USERNAME_DEFAULT}"}"

REALNAME_DEFAULT="$(getent passwd "$(whoami)" | cut -d ':' -f 5 | cut -d ',' -f 1)"
read -e -p "Which real name you want to use (default = ) > " REALNAME_READ
REALNAME="${REALNAME_READ:-"${REALNAME_DEFAULT}"}"

NICKS_DEFAULT="${USERNAME},${USERNAME}1"
read -e -p "Which nicks you want to use (comma-separated, no spaces) > " NICKS_READ
NICKS="${NICKS_READ:-"${NICKS_DEFAULT}"}"

read -e -p "Client SSL cert (empty if not using) > " CLIENTCERT

read -e -p "Channels to autojoin on Freenode (comma-separated, no spaces) >" AUTOJOIN_FREENODE

read -e -p "Channels to autojoin on OFTC (comma-separated, no spaces) >" AUTOJOIN_OFTC


cat <<EOF > "${DIR}/irc.conf"
#
# irc.conf -- weechat v1.0-dev
#

[look]
buffer_switch_autojoin = off
buffer_switch_join = on
color_nicks_in_names = on
color_nicks_in_nicklist = on
color_nicks_in_server_messages = off
color_pv_nick_like_channel = on
ctcp_time_format = "%a, %d %b %Y %T %z"
display_away = local
display_ctcp_blocked = on
display_ctcp_reply = on
display_ctcp_unknown = on
display_host_join = on
display_host_join_local = on
display_host_quit = on
display_join_message = "329,332,333"
display_old_topic = on
display_pv_away_once = on
display_pv_back = on
highlight_channel = "\$nick"
highlight_pv = "\$nick"
highlight_server = "\$nick"
highlight_tags_restrict = "irc_privmsg,irc_notice"
item_away_message = on
item_channel_modes_hide_args = "k"
item_display_server = buffer_plugin
item_nick_modes = on
item_nick_prefix = on
msgbuffer_fallback = current
new_channel_position = none
new_pv_position = none
nick_color_force = ""
nick_color_hash = djb2
nick_color_stop_chars = "_|["
nick_completion_smart = speakers
nick_mode = prefix
nick_mode_empty = off
nicks_hide_password = "nickserv"
notice_as_pv = auto
notice_welcome_redirect = on
notice_welcome_tags = ""
notify_tags_ison = "notify_message"
notify_tags_whois = "notify_message"
part_closes_buffer = off
pv_buffer = independent
pv_tags = "notify_private"
raw_messages = 256
server_buffer = merge_with_core
smart_filter = on
smart_filter_delay = 5
smart_filter_join = on
smart_filter_join_unmask = 30
smart_filter_mode = "+"
smart_filter_nick = on
smart_filter_quit = on
topic_strip_colors = off

[color]
input_nick = lightcyan
item_away = yellow
item_channel_modes = default
item_lag_counting = default
item_lag_finished = yellow
item_nick_modes = default
message_join = green
message_quit = red
mirc_remap = "1,-1:darkgray"
nick_prefixes = "q:lightred;a:lightcyan;o:lightgreen;h:lightmagenta;v:yellow;*:lightblue"
notice = green
reason_quit = default
topic_new = white
topic_old = default

[network]
alternate_nick = on
autoreconnect_delay_growing = 2
autoreconnect_delay_max = 1800
ban_mask_default = "*!\$user@\$host"
colors_receive = on
colors_send = on
lag_check = 60
lag_max = 1800
lag_min_show = 500
lag_reconnect = 0
lag_refresh_interval = 1
notify_check_ison = 1
notify_check_whois = 5
send_unknown_commands = off
whois_double_nick = on

[msgbuffer]

[ctcp]

[ignore]

[server_default]
addresses = ""
anti_flood_prio_high = 2
anti_flood_prio_low = 2
autoconnect = off
autojoin = ""
autoreconnect = on
autoreconnect_delay = 10
autorejoin = off
autorejoin_delay = 30
away_check = 5
away_check_max_nicks = 0
capabilities = ""
command = ""
command_delay = 0
connection_timeout = 60
default_msg_kick = ""
default_msg_part = "WeeChat %v"
default_msg_quit = "WeeChat %v"
ipv6 = on
local_hostname = ""
nicks = ""
notify = ""
password = ""
proxy = ""
realname = ""
sasl_mechanism = dh-blowfish
sasl_password = ""
sasl_timeout = 15
sasl_username = ""
ssl = off
ssl_cert = ""
ssl_dhkey_size = 2048
ssl_fingerprint = ""
ssl_priorities = "NORMAL"
ssl_verify = on
username = ""

[server]
freenode.addresses = "chat.freenode.net/7000"
freenode.proxy
freenode.ipv6
freenode.ssl = on
freenode.ssl_cert = "${CLIENTCERT}"
freenode.ssl_priorities
freenode.ssl_dhkey_size = 1024
freenode.ssl_fingerprint
freenode.ssl_verify
freenode.password
freenode.capabilities
freenode.sasl_mechanism = dh-blowfish
freenode.sasl_username = "\${sec.data.freenode_username}"
freenode.sasl_password = "\${sec.data.freenode_pass}"
freenode.sasl_timeout
freenode.autoconnect = on
freenode.autoreconnect = on
freenode.autoreconnect_delay = 7
freenode.nicks = "${NICKS}"
freenode.username
freenode.realname = "${REALNAME}"
freenode.local_hostname
freenode.command
freenode.command_delay
freenode.autojoin = "${AUTOJOIN_FREENODE}"
freenode.autorejoin
freenode.autorejoin_delay
freenode.connection_timeout
freenode.anti_flood_prio_high
freenode.anti_flood_prio_low
freenode.away_check = 5
freenode.away_check_max_nicks = 0
freenode.default_msg_kick
freenode.default_msg_part
freenode.default_msg_quit
freenode.notify
oftc.addresses = "irc.oftc.net/6697"
oftc.proxy
oftc.ipv6
oftc.ssl = on
oftc.ssl_cert = "${CLIENTCERT}"
oftc.ssl_priorities
oftc.ssl_dhkey_size = 1024
oftc.ssl_fingerprint
oftc.ssl_verify = on
oftc.password
oftc.capabilities
oftc.sasl_mechanism = dh-blowfish
oftc.sasl_username = "\${sec.data.oftc_username}"
oftc.sasl_password = "\${sec.data.oftc_pass}"
oftc.sasl_timeout
oftc.autoconnect = on
oftc.autoreconnect = on
oftc.autoreconnect_delay = 7
oftc.nicks = "${NICKS}"
oftc.username
oftc.realname = "${REALNAME}"
oftc.local_hostname
oftc.command
oftc.command_delay
oftc.autojoin = "${AUTOJOIN_OFTC}"
oftc.autorejoin
oftc.autorejoin_delay
oftc.connection_timeout
oftc.anti_flood_prio_high
oftc.anti_flood_prio_low
oftc.away_check = 5
oftc.away_check_max_nicks = 0
oftc.default_msg_kick
oftc.default_msg_part
oftc.default_msg_quit
oftc.notify
bitlbee.addresses = "localhost"
bitlbee.proxy
bitlbee.ipv6
bitlbee.ssl
bitlbee.ssl_cert
bitlbee.ssl_priorities
bitlbee.ssl_dhkey_size
bitlbee.ssl_fingerprint
bitlbee.ssl_verify
bitlbee.password = "\${sec.data.bitlbee_pass}"
bitlbee.capabilities
bitlbee.sasl_mechanism
bitlbee.sasl_username
bitlbee.sasl_password
bitlbee.sasl_timeout
bitlbee.autoconnect = on
bitlbee.autoreconnect = on
bitlbee.autoreconnect_delay = 7
bitlbee.nicks = "${NICKS}"
bitlbee.username = "\${sec.data.bitlbee_username}"
bitlbee.realname = "${REALNAME}"
bitlbee.local_hostname
bitlbee.command
bitlbee.command_delay
bitlbee.autojoin = "&bitlbee"
bitlbee.autorejoin
bitlbee.autorejoin_delay
bitlbee.connection_timeout
bitlbee.anti_flood_prio_high
bitlbee.anti_flood_prio_low
bitlbee.away_check = 5
bitlbee.away_check_max_nicks = 0
bitlbee.default_msg_kick
bitlbee.default_msg_part
bitlbee.default_msg_quit
bitlbee.notify
EOF

