#!/bin/sh
sudo sysctl -w net.core.rmem_max=212992
sudo sysctl -w net.core.wmem_max=212992
sudo sysctl -w net.ipv4.tcp_rmem='4096        131072  6291456'
sudo sysctl -w net.ipv4.tcp_wmem='4096        131072  6291456'
sudo sysctl -w net.ipv4.tcp_mem='1507074      2009435 3014148'
sudo sysctl -w net.core.wmem_default=212992
sudo sysctl -w net.core.rmem_default=212992
