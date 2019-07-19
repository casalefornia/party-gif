#!/usr/bin/env bash
# Static image to party gif conversion script

# Install dependencies if necessary
if brew ls --versions ImageMagick > /dev/null; then
    # imagemagick is installed
    echo ImageMagick is installed
    else
    # imagemagick is not installed
    brew install ImageMagick
fi

# User input for color change rate
echo "Enter color change rate (10-50): "
read COLOR_CHANGE_RATE

# Convert original image into several color frames
for ((i=0; i <= 200 ; i++))
do
    if ! ((i % $COLOR_CHANGE_RATE)); then
        convert $1 -modulate 100,100,$i     party_mod_`printf "%03d" $i`.gif
    fi
done

# Add frames to one image, then save final copy
convert -delay 10 party_mod_*.gif -loop 0 party_final_`date '+%Y-%m-%d_%H-%M-%S'`.gif

# Notify user of saved image
echo Saved: party_`date '+%Y-%m-%d_%H-%M-%S'`.gif

# Cleanup the frames
rm party_mod_*.gif