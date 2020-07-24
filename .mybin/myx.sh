!/bin/bash
 case $filename in
    *.tar)      tar xf $filename;;
    *.tar.bz2)  tar xjf $filename;;
    *.tbz)      tar xjf $filename;;
    *.tbz2)     tar xjf $filename;;
    *.tgz)      tar xzf $filename;;
    *.tar.gz)   tar xzf $filename;;
    *.gz)       gunzip $filename;;
    *.bz2)      bunzip2 $filename;;
    *.zip)      unzip $filename;;
    *.Z)        uncompress $filename;;
    *)          echo "No extract option for $filename"
esac
