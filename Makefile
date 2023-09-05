COLOR := "\e[1;36m%s\e[0m\n"

PROTO_ROOT := .


install: buf-install

buf-install:
	@printf $(COLOR) "Install/update buf..."
	go install github.com/bufbuild/buf/cmd/buf@v1.26.1

check: buf-lint buf-breaking

.PHONY: gen
gen:
	@printf $(COLOR) "Run buf code generator..."
	(cd $(PROTO_ROOT) && buf generate)

buf-lint:
	@printf $(COLOR) "Run buf linter..."
	(cd $(PROTO_ROOT) && buf lint)

buf-breaking:
	@printf $(COLOR) "Run buf breaking changes check against main branch..."
	@(cd $(PROTO_ROOT) && buf breaking --against '.git#branch=main')
