VAULT_CLIENT_TIMEOUT=180s

pre-commit-init:
	pre-commit install

pre-commit-update:
	pre-commit autoupdate

.PHONY:tests
tests:
	go test ./...
