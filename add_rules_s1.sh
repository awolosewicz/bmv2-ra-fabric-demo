#!/bin/bash

simple_switch_CLI << _EOF_
table_add ipv4_host forward 192.187.1.11 => 00:00:00:00:00:01 00:00:00:00:00:11 0
table_add ipv4_host forward 192.187.2.11 => 00:00:00:00:00:02 00:00:00:00:00:21 1
_EOF_
