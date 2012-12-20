#!/bin/bash
# Let the user select an area, prompt for confirmation, upload the image to an imagebin,
# put the url in the X11 clipboard echo the url to the terminal (if any)
# - for imgbin inspired by
#   http://argandgahandapandpa.wordpress.com/2010/11/08/command-line-script-to-upload-images-to-imagebin/
# - for imgur inspired by
#   http://imgur.com/apps
#   http://imgur.com/tools/imgurbash.sh

# import - | ./imgbin.sh | xclip

imgur_apikey="b3625162d3418ac51a9ee805b1840452"

# check curl is available
type curl >/dev/null 2>/dev/null || {
  echo "Couln't find curl, which is required." >&2
  exit 17
}

type import >/dev/null 2>/dev/null || {
  echo "Couln't find import, which is required." >&2
  exit 17
}


if [ -n "$1" ]; then
     filename="$1"
else
    filename=$(tempfile --suffix ".png");
    #import - > $filename;
    import $filename;
fi;

display $filename

confirm=`xmessage -nearmouse -timeout 4 -print -buttons "imgur,imgbin,/tmp/,cancel" -default imgur "post the image?"`;

if [ "$confirm" = "cancel" ]; then
  exit;
fi

if [ "$confirm" = "imgur" ] || [ "$confirm" = "" ] ; then
  response=$(curl -F "key=$imgur_apikey" -H "Expect: " -F "image=@$filename" \
    http://imgur.com/api/upload.xml 2>/dev/null)
  # the "Expect: " header is to get around a problem when using this through
  # the Squid proxy. Not sure if it's a Squid bug or what.

  if [ $? -ne 0 ]; then
    echo "Upload failed" >&2
    exit;
  elif [ $(echo $response | grep -c "<error_msg>") -gt 0 ]; then
    echo "Error message from imgur:" >&2
    echo $response | sed -r 's/.*<error_msg>(.*)<\/error_msg>.*/\1/' >&2
    exit;
  fi


  # parse the response and output our stuff
  url=$(echo $response | sed -r 's/.*<original_image>(.*)<\/original_image>.*/\1/')
  deleteurl=$(echo $response | sed -r 's/.*<delete_page>(.*)<\/delete_page>.*/\1/')
  echo $url
  echo "Delete page: $deleteurl" >&2
fi

if [ "$confirm" = "imgbin" ]; then
  # user imagebin instead of imgur...
  url=$(curl  -s --form "nickname=$(hostname)" --form \
     "image=@$filename;type=$(file --brief -L --mime-type $filename)"\
      --form "disclaimer_agree=Y" --form "mode=add" --form "Submit=Submit"\
      http://imagebin.org/index.php -w '%{redirect_url}')
  echo $url
fi

if [ "$confirm" = "/tmp/" ]; then
  filename_new=$(zenity --title="Filename" --text="Filename" --entry --entry-text $filename);
  if [ "$filename" != $filename_new ]; then
    mv $filename $filename_new
  fi
  echo $filename_new;
else
  rm $filename
fi

# put the URLs on the clipboard if we have xsel or xclip
if [ $DISPLAY ]; then
  { type xsel >/dev/null 2>/dev/null && echo -n $url | xsel; } \
    || { type xclip >/dev/null 2>/dev/null && echo -n $url | xclip; } \
    || echo "Haven't copied to the clipboard: no xsel or xclip" >&2
else
  echo "Haven't copied to the clipboard: no \$DISPLAY" >&2
fi
