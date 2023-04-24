IMAGE_NAME := "pr_reviews_reminder"
ROCKET_CHANNEL := "dev"
ORGANIZATION := "OpenSourcePolitics"
ROCKET_URL :="https://osp.rocket.chat"


build:
	docker build . -t $(IMAGE_NAME)

run:
	@make build
	docker run -it -e ORGANIZATION=$(ORGANIZATION) -e GITHUB_ACCESS_TOKEN=$(GITHUB_ACCESS_TOKEN) -e ROCKET_URL=$(ROCKET_URL) -e NAMES_MAP=$(NAMES_MAP) -e ROCKET_USERNAME=$(ROCKET_USERNAME) -e ROCKET_PASSWORD=$(ROCKET_PASSWORD) --rm $(IMAGE_NAME)


