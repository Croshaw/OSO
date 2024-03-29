#!/bin/bash
awk '$2 == "INFO"' script5.temp.log > info.log
cat info.log
