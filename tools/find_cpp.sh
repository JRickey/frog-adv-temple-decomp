#!/bin/sh
# Print the GNU cpp the build pipeline uses. On macOS Homebrew renames the
# binary every major release (cpp-15, cpp-16, ...), so pick the newest one;
# elsewhere plain `cpp` is GNU already.
if [ "$(uname -s)" = Darwin ]; then
    c=$(ls /opt/homebrew/bin/cpp-[0-9]* /usr/local/bin/cpp-[0-9]* 2>/dev/null | sort -t- -k2 -n | tail -1)
    if [ -z "$c" ]; then
        echo "find_cpp.sh: no Homebrew GNU cpp found (brew install gcc)" >&2
        exit 1
    fi
    echo "$c"
else
    echo cpp
fi
