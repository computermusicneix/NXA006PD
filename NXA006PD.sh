#!/bin/bash

TITLE="NXA006PD-"`date +"%Y-%m-%d_%H_%M_%S"`
APPDIR=$(dirname "$0")"/NXC051/application.linux32"
DIRFLAC=$TITLE/$TITLE-flac
DIRMP3=$TITLE/$TITLE-mp3


echo $TITLE
echo $APPDIR

mkdir $TITLE
mkdir $DIRFLAC
mkdir $DIRMP3

for i in `seq 1 4`;
do

	java  -Djava.library.path="$APPDIR:$APPDIR/lib" -cp "$APPDIR/lib/NXC051.jar:$APPDIR/lib/core.jar:$APPDIR/lib/jogl-all.jar:$APPDIR/lib/gluegen-rt.jar:$APPDIR/lib/jogl-all-natives-linux-i586.jar:$APPDIR/lib/gluegen-rt-natives-linux-i586.jar" NXC051 "$@"

done

COUNT=0

for x in nxPD*;
do
	$((COUNT=$COUNT+1))
	NEW=$TITLE-$COUNT.wav
	echo $NEW
	mv $x $NEW
done

COUNT=0

for x in GRAPH*;
do
	$((COUNT=$COUNT+1))
	NEW=$TITLE-$COUNT.jpg
	echo $NEW
	mv $x $NEW
done

lame -b320 --ta 'Miquel Parera' --tc 'cc-by-sa' --tt $TITLE-1 --tl  $TITLE --tn 1/4 --ty `date +"%Y"` --ti $TITLE-1.jpg $TITLE-1.wav $TITLE-1.mp3

sleep 1

lame -b320 --ta 'Miquel Parera' --tc 'cc-by-sa' --tt $TITLE-2 --tl  $TITLE --tn 2/4 --ty `date +"%Y"` --ti $TITLE-2.jpg $TITLE-2.wav $TITLE-2.mp3

sleep 1

lame -b320 --ta 'Miquel Parera' --tc 'cc-by-a' --tt $TITLE-3 --tl  $TITLE --tn 3/4 --ty `date +"%Y"` --ti $TITLE-3.jpg $TITLE-3.wav $TITLE-3.mp3

sleep 1

lame -b320 --ta 'Miquel Parera' --tc 'cc-by-sa' --tt $TITLE-4 --tl  $TITLE --tn 4/4 --ty `date +"%Y"` --ti $TITLE-4.jpg $TITLE-4.wav $TITLE-4.mp3

sleep 1

sox $TITLE-1.wav -C 8 $TITLE-1.flac
id3v2 -a 'Miquel Parera' -c 'cc-by-sa' -t $TITLE-1 -A $TITLE -T 1/4 -y `date +"%Y"` $TITLE-1.flac

sox $TITLE-2.wav -C 8 $TITLE-2.flac
id3v2 -a 'Miquel Parera' -c 'cc-by-sa' -t $TITLE-2 -A $TITLE -T 2/4 -y `date +"%Y"` $TITLE-2.flac

sox $TITLE-3.wav -C 8 $TITLE-3.flac
id3v2 -a 'Miquel Parera' -c 'cc-by-sa' -t $TITLE-3 -A $TITLE -T 3/4 -y `date +"%Y"` $TITLE-3.flac

sox $TITLE-4.wav -C 8 $TITLE-4.flac
id3v2 -a 'Miquel Parera' -c 'cc-by-sa' -t $TITLE-4 -A $TITLE -T 4/4 -y `date +"%Y"` $TITLE-4.flac

for x in *.flac;
do
	mv $x $DIRFLAC
done

for x in *.mp3;
do
	mv $x $DIRMP3
done

for x in *.jpg;
do
	cp $x $DIRFLAC
done

for x in *.jpg;
do
	mv $x $DIRMP3
done

rm $TITLE-1.wav
rm $TITLE-2.wav
rm $TITLE-3.wav
rm $TITLE-4.wav

echo '**********END*************'

exit 0


