#!/bin/bash
awk 'END{print NR}' /var/log/*.log
