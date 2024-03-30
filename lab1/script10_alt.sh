man bash | tr '[:punct:]' '\n' | tr '[:upper:]' '[:lower:]' | grep -oE '\b\w{4,}\b' | sort | uniq -c | sort -nr | head -n 3
