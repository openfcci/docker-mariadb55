setup:
ifndef DBPASS
	$(error DBPASS not set. Use make DBPASS=<password> NAME=<instance name> setup)
endif

ifndef NAME
	$(error NAME not set. Use make DBPASS=<password> NAME=<instance name> setup)
endif

	mkdir -p $(HOME)/$(NAME)/data
	mkdir -p $(HOME)/$(NAME)/backup
	-docker rm -f $(NAME) 
	-docker rm -f $(NAME)-restore
	-docker rm -f $(NAME)-backup
	docker run -d --name $(NAME) -v $(HOME)/$(NAME)/data:/var/lib/mysql -v $(HOME)/$(NAME)/backup:/mnt/backup -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$(DBPASS) fcc-mariadb55
	docker create --name $(NAME)-restore -v $(HOME)/$(NAME)/data:/var/lib/mysql -v $(HOME)/$(NAME)/backup:/mnt/backup fcc-mariadb55 restore.sh
	docker create --name $(NAME)-backup --link $(NAME) -v $(HOME)/$(NAME)/data:/var/lib/mysql -v $(HOME)/$(NAME)/backup:/mnt/backup fcc-mariadb55 backup.sh root $(DBPASS)

build:
	docker build -t fcc-mariadb55 .
