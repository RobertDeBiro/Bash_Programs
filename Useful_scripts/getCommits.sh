#! /bin/bash

preDir=$(pwd)
tags=$1
since=$2
until=$3
branch="origin/master"


if [ "$#" -ne 3 ]; then
    echo "example single tag search: getCommits.sh MR:4504 2018-10-01 2018-10-21"
    echo "example multiple tag search: getCommits.sh \"MR:4504|MR:3295\" 2018-10-01 2018-10-21"
else

    if [ -z ${MY_GIT_TOP+x} ]; then
        
        echo "please do: source gitenv.csh/gitenv.sh inside repo"

    else

        htmlFile="$preDir/freqOfDelivery1.html"
        echo "
        <!DOCTYPE html>
        <html>
        <head>
        <title>Frequency of delivery $1</title>
        <style>
        #frequency {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #frequency td, #frequency th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #frequency tr:nth-child(even){background-color: #f2f2f2;}

        #frequency tr:hover {background-color: #ddd;}

        #frequency th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #3E49BB;
            color: white;
        }
        </style>
        </head>
        <body>

        <h2>Frequency of delivery for $1 since $2 until $3:</h2>" > $htmlFile
        cd $MY_GIT_TOP/.git/info
		
		rm -rf /home/eukrmra/scripts/temp1.txt
        
        echo "<table id=\"frequency\">" >> $htmlFile
        echo "<tr><th>Commit id</th><th>Author</th><th>Date</th><th>Design</th><th>Unit</th><th>BIT</th><th>MCT</th></tr>" >> $htmlFile

        for sha in $(git log $branch --reverse --pretty=oneline --since=$since --until=$until | grep -E "$tags" | awk '{print $1}'); do
	
            authorMail=$(git show -s --format=%ae $sha)
            mergeDate=$(git show -s --format=%ci $sha | awk '{print $1}')
            fileChanged=$(git --no-pager diff $sha~1 $sha --numstat)

            Design=0
            BIT=0
            MCT=0
			Unit=0

            while read -r line ; do
	
                added=$(echo $line | awk '{print $1}')
                removed=$(echo $line | awk '{print $2}')
                fileName=$(echo $line | awk '{print $3}')
	
				a="-"

				if [ $a = $added ]
				then
					continue
				fi

                echo "$fileName" >> /home/eukrmra/scripts/temp1.txt

                if grep -q .erl <<<"$fileName"
				then
                    MCT=$[MCT+$added+$removed]
                elif grep -q .hrl <<<"$fileName"
				then
                    MCT=$[MCT+$added+$removed]
                elif grep -e /bit/ <<<"$fileName"
                then
                    BIT=$[BIT+$added+$removed]
				elif grep -e test <<<"$fileName"
                then
                    Unit=$[Unit+$added+$removed]
				else
                    Design=$[Design+$added+$removed]
                fi
            done <<< "$fileChanged"
            
            echo "<tr><td>$sha</td><td>$authorMail</td><td>$mergeDate</td><td>$Design</td><td>$Unit</td><td>$BIT</td><td>$MCT</td></tr>" >> $htmlFile

        done

        echo "
        </table>
        </body>
        </html>" >> $htmlFile

        cd $preDir
        firefox "$htmlFile"
    fi
fi
