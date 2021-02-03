#!/bin/bash

echo "waiting for db"
while pg_isready --quiet --host=db; [ $? -ne 0 ];
do 
	sleep 2
done

echo "$(date) - connected"
