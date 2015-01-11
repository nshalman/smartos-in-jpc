#!/bin/bash

PLATFORM=http://us-east.manta.joyent.com/nahamu/public/smartos/platform-hourly.tgz
SNAPSHOT=zones/smartos@pre-upgrade

#so that we can fail on either curl or gtar
set -o pipefail 

function already_latest
{
	echo "Already have the latest version."
	exit 0
}

function fail
{
	zfs rollback $SNAPSHOT
	echo "Upgrade failed. Rolled back to working state."
	exit 1
}

cd /zones/smartos
curl -I $PLATFORM 2>/dev/null | grep Etag > etag.latest
diff etag.current etag.latest && already_latest

zfs destroy $SNAPSHOT &>/dev/null #If it exists, destroy it
zfs snapshot $SNAPSHOT

(cd platform && curl $PLATFORM | gtar xz --strip-components=1) || fail
mv etag.latest etag.current

echo "Upgrade complete. Reboot when ready."
exit 0
