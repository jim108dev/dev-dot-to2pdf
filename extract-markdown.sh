#!/bin/bash
set -e
md_dir=./download_markdown
pdf_dir=./pdf

mkdir -p $md_dir
mkdir -p $pdf_dir

for url in $(cat articles.txt)
do
	echo $url
    article_name=`basename $url`
    echo $article_name
    curl -s $url | json body_markdown > $md_dir/$article_name.md
    pandoc --listings -s -t context $md_dir/$article_name.md > out.tex
    context out.tex > /dev/null
    mv out.pdf $pdf_dir/$article_name.pdf
    rm -f out.log out-mpgraph.mp out.tui out.tuc out.tuo out.tmp out-appendix.tmp out.tex
done