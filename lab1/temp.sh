sudo grep -r -o -h -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Z|a-z]{2,}" /etc/ | sed 's/$/,/'
