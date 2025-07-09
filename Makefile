DATA_DIRS			= mariadb wordpress
CREATE_DATA_DIRS	= $(DATA_DIRS:%=create)
DELETE_DATA_DIRS	= $(DATA_DIRS:%=delete)

up:		$(CREATE_DATA_DIRS)
		docker-compose -f srcs/docker-compose.yml up --build -d

down:
		docker-compose -f srcs/docker-compose.yml down

create:
		mkdir -p /home/tchartie/data/$*

delete:
		sudo rm -rf /home/tchartie/data/$*

.PHONY:	up down create delete