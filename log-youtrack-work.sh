#!/bin/bash 

set -e;

CSV_FILE=$1;
AUTH_TOKEN="set your user token";
YOUTRACK_HOST="https://company.myjetbrains.com";

function logWork {
        curl --location --request POST "${YOUTRACK_HOST}/youtrack/rest/issue/${issue}/timetracking/workitem" \
                --header "Authorization: Bearer ${AUTH_TOKEN}" \
                --header 'Content-Type: application/xml' \
                --data-raw "<workItem>
            <date>$unix_date</date>
                <duration>$duration</duration>
                    <description>$description</description>
                        <worktype>
                                <name>$workitem_type</name>
                                    </worktype>
                                    </workItem>"
}

x=1
while IFS=, read -r date duration issue type description  
do
        unix_date=$(date "+%s%3N" -d ${date})
        duration=$(echo ${duration} | sed 's/"//g')
        issue=$(echo ${issue} | sed 's/"//g')
        workitem_type=$(echo ${type} | sed 's/"//g')
        description=$(echo ${description} | sed 's/"//g')
        logWork
        echo "Row: '${x}', work logged in issue ${issue} as '${workitem_type}'"
        x=$(( $x + 1 ))
done < ${CSV_FILE}
