# Using Jaseci and Jaseci-Kit to Sort files

## Introduction
The idea for sorting files was had because my Downloads folders became crowded. At first a bash script was gonna do the work, with precoded file extensions already sorted into arrays. The idea of adding jaseci-kit to the mix was just a thought, but soon became an active tinkering. These are the results.

## Running the Script

Some stock files have been included to test the functionality and effectiveness of the program.
First you will need some dependencies (if they are not already installed). For parsing the json data that jaseci outputs:
#### Dependencies
```
sudo apt install jshon jq
```
or use your distros respective package manager to install.

Next just cd into the directory and run the script (it will need executable permissions). Though you may want to look around first.  
```
git clone https://github.com/maxthemage/jaseci-tinkerings.git
cd jaseci-tinkerings/sort_files/ 
chmod + x sort_files.sh
./sort_file.sh
```

The script will take some time to run, especially the first time, since to has to load the jaseci_kit module and the jac program. It will also spit out the feed from loading the module, since I have not gotten around to cleaning that up as yet.

## Overview of the Program 

The program consists of two main parts; a bash script and a jac program. The bash script serves to not only parse the output from the jac program, but to run it, as well as do the actual sorting, as in moving files around to their respective directories. The script start begins by declaring a hardcoded list of folders to sort the files into. It outputs that data along with a list of the files in the directory, for the jac program to read. It then loads up the "jaseci_kit.use_qa" module, saving the session, to the default session file. The jac program the executes to the the bulk of the logic needed to place the files into the given folders. It does this by associating the folder names, to each of the sortable files in it's directory. It does a json dump of the files and their most appropriate directory, and Walla! Bash moves them around.

## Shortcomings

* Though the module seems to work very well, it can sometimes miscategorize the files! Although it is to be noted that it only has the file names to go off of.
* The user cannot directly name the folders based on their file types, so there isn't much specificity

### For WSL users!!
I tried testing and running this on WSL but to no avail. The module spits out some weird error. Will try to resolve asap.

## Improvements to be made

* While the module has had times where it incorrectly categorizes the file, it is only as good as the input given. I have already thought of ways to improve, though I  hadn't the time to fully implement it.
* User input would be a very neat addition, as in having the user, name the folders for themselves, based on what files they have present.
* The large amounts of output that module and jaseci spits out can be cleaned up.
* The codebase (especially bash) can use some cleaning up.

### Comments
I worked on this in most of the free time I had, but ultimately time was against me and was the biggest shortcoming of this project. I hope to complete it fully, with the original idea that was had.


