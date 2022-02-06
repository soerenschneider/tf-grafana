tf-init:
	pre-commit install
	terraform -chdir=tf init

tf-plan:
	terraform -chdir=tf plan

tf-apply:
	terraform -chdir=tf apply

tf-destroy:
	terraform -chdir=tf destroy
