#!/bin/bash
(sleep $1 ; ./script1.sh) &
tail -f ~/report
