#!/bin/bash
grep '\*\*' script6.temp.log | sed 's/\*\*/Warning:/g' > full1.log
grep '!!' script6.temp.log | sed 's/!!/Information:/g' >> full1.log
cat full1.log
