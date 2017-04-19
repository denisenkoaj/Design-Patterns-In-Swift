#!/bin/bash

cleanThisMessForReadme () {

	FILENAME=$1

	{ rm $FILENAME && awk '{gsub("\\*/", "\n```swift\n", $0); print}' > $FILENAME; } < $FILENAME
	{ rm $FILENAME && awk '{gsub("\\*//\\*:", "", $0); print}' > $FILENAME; } < $FILENAME
	{ rm $FILENAME && awk '{gsub("/\\*:", "```\n", $0); print}' > $FILENAME; } < $FILENAME
	{ rm $FILENAME && awk '{gsub("//\\*:", "", $0); print}' > $FILENAME; } < $FILENAME
	{ rm $FILENAME && awk '{gsub("//:", "", $0); print}' > $FILENAME; } < $FILENAME
	{ rm $FILENAME && awk 'NR>1{print buf}{buf = $0}' > $FILENAME; } < $FILENAME
}

makePlayground () {
  for i in $( ls source/$1 );
  do

  if [[ $i == *"title"* ]]; then
  continue
  fi

  cat source/$1/_title.swift source/$1/$i > $i
  baseName=`echo $i | cut -d "." -f 1`

  cp $i ./$1.playground/Pages/$baseName.xcplaygroundpage/Contents.swift
  rm $i

  done
}

cat source/behavioral/* > ./Behavioral.swift
cat source/creational/* > ./Creational.swift
cat source/structural/* > ./Structural.swift

cp ./Behavioral.swift ./Design-Patterns.playground/Pages/Behavioral.xcplaygroundpage/Contents.swift
cp ./Creational.swift ./Design-Patterns.playground/Pages/Creational.xcplaygroundpage/Contents.swift
cp ./Structural.swift ./Design-Patterns.playground/Pages/Structural.xcplaygroundpage/Contents.swift

cat source/header.swift source/*/* source/footer.swift > ./contents.swift

cleanThisMessForReadme ./contents.swift

cp ./contents.swift ./README.md

#zip -r -X Design-Patterns.playground.zip ./Design-Patterns.playground

rm ./Behavioral.swift
rm ./Creational.swift
rm ./Structural.swift
rm ./contents.swift

makePlayground Behavioral
makePlayground Creational
makePlayground Structural

zip -r -X Design-Patterns.zip ./Behavioral.playground ./Creational.playground ./Structural.playground


