# DO NOT USE NEITHER KUBERNETES NOR HELM COMMANDS. USE ONLY THIS MAKEFILE!

.PHONY: install deploy

ifneq ($(filter install deploy,$(MAKECMDGOALS)),$())
ifndef TAG
$(error TAG is not defined)
endif
endif

ifneq ($(filter install deploy,$(MAKECMDGOALS)),$())
ifndef NAME
$(error NAME is not defined)
endif
endif

CHART_PATH ?= .

DEPLOY_CMD  = "helm upgrade ${NAME} ${CHART_PATH} "
DEPLOY_CMD += "-f helm_vars/values.yaml "

ifneq ($(filter deploy,$(MAKECMDGOALS)),$())
ifdef TAG
DEPLOY_CMD += "--set image.tag=${TAG}"
endif
endif

install:
	helm install ${CHART_PATH} \
		-f helm_vars/values.yaml \
		--set image.tag=${TAG}

deploy:
	@eval $(DEPLOY_CMD)