#!/usr/bin/env bash
set -xeuo pipefail

TMBENCH_FINISH_WAIT=${TMBENCH_FINISH_WAIT:-0}

#
# This script executes tm-bench according to arrays of values given via the
# relevant environment variables (TMBENCH_ENDPOINTS, TMBENCH_TIME, etc.). It
# will execute them immediately one after the other, unless TMBENCH_FINISH_WAIT
# is set, in which case the script will sleep between each execution.
#

IFS=";" read -ra TMBENCH_ENDPOINTS_ARR <<< "${TMBENCH_ENDPOINTS}"
TMBENCH_RUNS=${#TMBENCH_ENDPOINTS_ARR[@]}

IFS=";" read -ra TMBENCH_TIME_ARR <<< "${TMBENCH_TIME}"
count=${#TMBENCH_TIME_ARR[@]}
if [ "${TMBENCH_RUNS}" -ne "${count}" ]; then
    echo "Number of entries in TMBENCH_TIME does not match TMBENCH_ENDPOINTS"
    exit 1
fi

IFS=";" read -ra TMBENCH_BROADCAST_TX_METHOD_ARR <<< "${TMBENCH_BROADCAST_TX_METHOD}"
count=${#TMBENCH_BROADCAST_TX_METHOD_ARR[@]}
if [ "${TMBENCH_RUNS}" -ne "${count}" ]; then
    echo "Number of entries in TMBENCH_BROADCAST_TX_METHOD does not match TMBENCH_ENDPOINTS"
    exit 1
fi

IFS=";" read -ra TMBENCH_CONNECTIONS_ARR <<< "${TMBENCH_CONNECTIONS}"
count=${#TMBENCH_CONNECTIONS_ARR[@]}
if [ "${TMBENCH_RUNS}" -ne "${count}" ]; then
    echo "Number of entries in TMBENCH_CONNECTIONS does not match TMBENCH_ENDPOINTS"
    exit 1
fi

IFS=";" read -ra TMBENCH_RATE_ARR <<< "${TMBENCH_RATE}"
count=${#TMBENCH_RATE_ARR[@]}
if [ "${TMBENCH_RUNS}" -ne "${count}" ]; then
    echo "Number of entries in TMBENCH_RATE does not match TMBENCH_ENDPOINTS"
    exit 1
fi

IFS=";" read -ra TMBENCH_SIZE_ARR <<< "${TMBENCH_SIZE}"
count=${#TMBENCH_SIZE_ARR[@]}
if [ "${TMBENCH_RUNS}" -ne "${count}" ]; then
    echo "Number of entries in TMBENCH_SIZE does not match TMBENCH_ENDPOINTS"
    exit 1
fi

for (( run = 0; run < $TMBENCH_RUNS; run++ )); do
    tm-bench \
        -T ${TMBENCH_TIME_ARR[$run]} \
        -broadcast-tx-method ${TMBENCH_BROADCAST_TX_METHOD_ARR[$run]} \
        -c ${TMBENCH_CONNECTIONS_ARR[$run]} \
        -r ${TMBENCH_RATE_ARR[$run]} \
        -s ${TMBENCH_SIZE_ARR[$run]} \
        -v \
        ${TMBENCH_ENDPOINTS_ARR[$run]}
    
    echo "Sleeping ${TMBENCH_FINISH_WAIT} seconds..."
    sleep ${TMBENCH_FINISH_WAIT}
done
