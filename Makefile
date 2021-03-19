DB_HOST=localhost
DB_PORT=2345
DB_NAME=studs
#DB_USER=s666666

all: help

help:
	@echo "mmigrate ----------- - Generate and use migrations."
	@echo "  migrate ---------- - Use migrations."
	@echo "  makemigrations --- - Generate migrations."
	@echo "clean -------------- - Remove .pyc/__pycache__ files."
	@echo "forward_db --------- - Forward db port."
	@echo "init_hbf_db -------- - Create hbf db objects."
	@echo "load_hbf_db -------- - Load hbf db data."
	@echo "drop_hbf_db -------- - Drop hbf db objects.."
	@echo "run ---------------- - Run dev server."

migrations:
	python manage.py makemigrations

migrate:
	python manage.py migrate

mmigrate: makemigrations migrate

clean:
	-find . -type f -a \( -name "*.pyc" -o -name "*$$py.class" \) | xargs rm
	-find . -type d -name "__pycache__" | xargs rm -r

run:
	python manage.py runserver

forward_db:
	ssh -L $(DB_PORT):pg:5432 -p 2222 $(DB_USER)@se.ifmo.ru

init_hbf_db:
	psql -h $(DB_HOST) -p $(DB_PORT) -W $(DB_NAME) $(DB_USER) -f human_blood_flow/sql/init.sql

load_hbf_db:
	psql -h $(DB_HOST) -p $(DB_PORT) -W $(DB_NAME) $(DB_USER) -f human_blood_flow/sql/load.sql

drop_hbf_db:
	psql -h $(DB_HOST) -p $(DB_PORT) -W $(DB_NAME) $(DB_USER) -f human_blood_flow/sql/drop.sql

ngrok:
	ngrok http 8000

user:
	python manage.py createsuperuser --skip-checks --email admin@host.org
