#!/bin/bash
grep '\*\*' script6.temp.log | sed 's/\*\*/Warning:/g' > full.log
grep '!!' script6.temp.log | sed 's/!!/Information:/g' >> full.log
cat full.log
