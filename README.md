# Log your work - Youtrack

The purpose of this tool is log your work to Youtrack from a csv file.

## How to use it

1. Generate a token
2. Set generated token in AUTH_TOKEN variable
3. Generate csv file. See
4. Run script `./log-youtrack-work.sh filename.csv`

## Generating csv file

The format of the csv file is 
```text
06/29/20,10,PROJECT-1,"A work item type","Daily meeting"
```

### Columns

1. Date
1. Issue id
1. Work item type
1. Description

## How to get work item types

```bash
YOUTRACK_HOST="https://company.myjetbrains.com"
curl --location --request GET '${YOUTRACK_HOST}/youtrack/api/admin/timeTrackingSettings/workItemTypes?fields=$type,autoAttached,id,name' \
    --header "Authorization: Bearer ${AUTH_TOKEN}"
```

Important: not all types are enabled for all issues. The default types are the ones with attribute `autoAttached` in true.