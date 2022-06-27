#!/usr/bin/bash

FOLDERS=("Audios" "Code" "Documents" "Pictures" "Videos")

rm -rf .folders.txt
for folder in "${FOLDERS[@]}"; do
	echo "$folder" >> .folders.txt
	echo "****" >> .folders.txt
done

ls -p -I json.sh -I js.session -I main.jac -I sort_files.sh -I README.md -I *.git | grep -v / > .files.txt
jsctl actions load module jaseci_kit.use_qa && jsctl -f js.session jac run main.jac
cat .jaseci_output.txt > .jaseci_output.json
cat .jaseci_output.json | jq -r '.[]' > .sorted_folders.txt
cat .jaseci_output.json | jshon -k > .sorted_files.txt

mapfile -t SORTED_FILES < .sorted_files.txt
mapfile -t SORTED_FOLDERS < .sorted_folders.txt

for (( i=0; i<"${#SORTED_FILES[@]}"; i++ ))
do	
	DIR=$(echo "${SORTED_FOLDERS[i]}")
	echo "$DIR" 
	if [ -d "$DIR" ]; then
		mv "${SORTED_FILES[i]}" "${SORTED_FOLDERS[i]}"
	else
		mkdir ${SORTED_FOLDERS[i]}
		mv "${SORTED_FILES[i]}" "${SORTED_FOLDERS[i]}"
	fi
done
rm -rf .file.txt .folder.txt .sorted_folders.txt .sorted_files.txt .jaseci_output.txt .jaseci_output.json
