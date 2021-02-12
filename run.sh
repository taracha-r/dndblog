#!/bin/bash
if [ "$WAIT_FOR_DB" = "1" ]; then
	/app/deploy/wait_for_db.sh
fi

python backend/manage.py migrate && python /app/backend/manage.py collectstatic --noinput -i static  && python backend/manage.py runserver 0.0.0.0:8000 --settings=dndblog.settings 

