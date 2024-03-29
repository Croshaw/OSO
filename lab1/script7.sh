#!/bin/bash
grep -h -I -r -E -o '\b[A-Za-z0-9]+@[A-Z|a-z]+\.[A-Z|a-z]+\b' /etc/* >> emails.lst
cat emails.lst
