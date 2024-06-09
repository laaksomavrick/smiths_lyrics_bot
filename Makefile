.PHONY: build
build:
	@sam build -t template.yaml --parallel

.PHONY: deploy
deploy:
	@sam deploy --resolve-image-repos

.PHONY: format
format:
	@bundler exec rubocop -A