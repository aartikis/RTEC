#!/bin/bash
# Checks of the event description (see checkEventDescription/2 in src/compiler.prolog).
# (i) Each checks/<case>/rules.prolog is compiled in a temporary folder, and the warnings and errors of the
#     compiler are compared with checks/<case>/expected_messages.txt. The compiler must exit with status 0, or
#     with the status in checks/<case>/expected_exit.txt.
# (ii) The event descriptions of the example applications must compile without messages.
COMPILERPATH="$(pwd)/../../src/compiler.prolog"
EXAMPLESPATH="$(pwd)/../../examples"
FAILED=0

# compile <event description> <temporary folder>: print the warnings and errors of the compiler, with paths
# relative to the temporary folder, and return the exit status of swipl.
compile() {
    cp "$1" "$2/rules.prolog"
    swipl -q -l "$COMPILERPATH" -g "compileED('$2/rules.prolog', withoutOptimisation),halt" 2> "$2/stderr.txt" > /dev/null
    STATUS=$?
    grep -E '^RTEC (warning|error)' "$2/stderr.txt" | sed "s#$2/##"
    return $STATUS
}

for testi in $(ls checks); do
    echo "--------------------------------------------------------------------"
    echo "Checking folder : checks/$testi"
    TMP=$(mktemp -d)
    EXPECTEDEXIT=0
    if [ -f "./checks/$testi/expected_exit.txt" ]; then
        EXPECTEDEXIT=$(cat "./checks/$testi/expected_exit.txt")
    fi
    compile "./checks/$testi/rules.prolog" "$TMP" > "$TMP/messages.txt"
    EXIT=$?
    if [ "$EXIT" -eq "$EXPECTEDEXIT" ] && diff "./checks/$testi/expected_messages.txt" "$TMP/messages.txt" > /dev/null; then
        echo "-----Status: PASSED"
    else
        echo "-----Status: FAILED"
        echo "exit status $EXIT, expected $EXPECTEDEXIT"
        diff "./checks/$testi/expected_messages.txt" "$TMP/messages.txt"
        FAILED=1
    fi
    rm -rf "$TMP"
done

for app in $(ls "$EXAMPLESPATH"); do
    echo "--------------------------------------------------------------------"
    echo "Checking example : $app"
    TMP=$(mktemp -d)
    compile "$EXAMPLESPATH/$app/resources/patterns/rules.prolog" "$TMP" > "$TMP/messages.txt"
    EXIT=$?
    if [ "$EXIT" -eq 0 ] && [ ! -s "$TMP/messages.txt" ]; then
        echo "-----Status: PASSED"
    else
        echo "-----Status: FAILED"
        echo "exit status $EXIT"
        cat "$TMP/messages.txt"
        FAILED=1
    fi
    rm -rf "$TMP"
done

exit $FAILED
