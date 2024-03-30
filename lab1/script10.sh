#!/bin/bash
man bash | grep -oE '\b\w{4,}\b' | sort | uniq -c | sort -nr | head -n 3
