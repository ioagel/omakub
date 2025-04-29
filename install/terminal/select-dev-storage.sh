# Install default databases
if [[ -v OMAKUB_FIRST_RUN_DBS ]]; then
	dbs=$OMAKUB_FIRST_RUN_DBS
else
	AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
	dbs=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
fi

if [[ -n "$dbs" ]]; then
	# Use a while loop to correctly process newline-separated dbs
	while IFS= read -r db; do
		# Skip empty lines potentially resulting from read
		[[ -z "$db" ]] && continue
		case $db in
		MySQL)
			if ! sudo docker inspect mysql8 >/dev/null 2>&1; then
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4
			else
				echo "Container 'mysql8' already exists."
			fi
			;;
		Redis)
			if ! sudo docker inspect redis >/dev/null 2>&1; then
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7
			else
				echo "Container 'redis' already exists."
			fi
			;;
		PostgreSQL)
			if ! sudo docker inspect postgres16 >/dev/null 2>&1; then
				sudo docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" --name=postgres16 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:16
			else
				echo "Container 'postgres16' already exists."
			fi
			;;
		esac
	done <<<"$dbs" # Pipe the dbs variable into the loop
fi
