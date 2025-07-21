DATA_DIRS			= mariadb wordpress
CREATE_DATA_DIRS	= $(DATA_DIRS:%=create-%)
DELETE_DATA_DIRS	= $(DATA_DIRS:%=delete-%)

up:		$(CREATE_DATA_DIRS)
		docker compose -f srcs/docker-compose.yml up --build -d

down:
		docker compose -f srcs/docker-compose.yml down -v

create-%:
		mkdir -p /home/tchartie/data/$*

delete-%:
		sudo rm -rf /home/tchartie/data/$*

clean:	down $(DELETE_DATA_DIRS)
		docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
		docker rmi -f $$(docker images -qa); \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q) || true

.PHONY:	up down create-% delete-% clean