IMAGE_NAME := "pr_reviews_reminder"
ROCKET_CHANNEL := "\#review"
ORGANIZATION := "OpenSourcePolitics"
ROCKET_URL :="https://osp.rocket.chat"
API_TOKEN := "dummy"
PORT := 8080


build:
	docker build . -t $(IMAGE_NAME)

run:
	@make build
	docker run -it -p $(PORT):8080 -e ROCKET_CHANNEL=$(ROCKET_CHANNEL) -e API_TOKEN=$(API_TOKEN) -e ORGANIZATION=$(ORGANIZATION) -e GITHUB_ACCESS_TOKEN=$(GITHUB_ACCESS_TOKEN) -e ROCKET_URL=$(ROCKET_URL) -e NAMES_MAP=$(NAMES_MAP) -e ROCKET_USERNAME=$(ROCKET_USERNAME) -e ROCKET_PASSWORD=$(ROCKET_PASSWORD) --rm $(IMAGE_NAME)


