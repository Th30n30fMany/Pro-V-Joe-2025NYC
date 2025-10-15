#!/bin/bash
OUTDIR="$1"; TOKEN="$2"
mkdir -p "$OUTDIR"
ssh-keygen -t rsa -b 2048 -f "$OUTDIR/id_rsa_$TOKEN" -N "" -C "backup@$TOKEN" >/dev/null 2>&1
echo "Created $OUTDIR/id_rsa_$TOKEN and $OUTDIR/id_rsa_$TOKEN.pub"
