.PHONY: version run test format lint release all

# Define ANSI escape codes for colors and formatting
RESET_COLOR = \033[0m
BOLD = \033[1m
RED = \033[91m
GREEN = \033[92m
YELLOW = \033[93m
BLUE = \033[94m

version:
	@echo "$(BOLD)Rust CLI Versions:$(RESET_COLOR)"
	@echo "------------------"
	@echo "$(BLUE)rustc (compiler):$(RESET_COLOR)            $(shell rustc --version | sed 's/rustc //' | tr -d '\n')"
	@echo "$(BLUE)cargo (package manager):$(RESET_COLOR)     $(shell cargo --version | sed 's/cargo //' | tr -d '\n')"
	@echo "$(BLUE)rustfmt (code formatter):$(RESET_COLOR)    $(shell rustfmt --version | sed 's/rustfmt //' | tr -d '\n')"
	@echo "$(BLUE)clippy (linter):$(RESET_COLOR)             $(shell clippy-driver --version | sed 's/clippy //' | tr -d '\n')"
	@echo "$(BLUE)rustup (toolchain manager):$(RESET_COLOR)  $(shell rustup --version 2>/dev/null | sed 's/rustup //' | tr -d '\n')"

format:
	@echo "$(BLUE)$(BOLD)Formatting code...$(RESET_COLOR)"
	$(shell cargo fmt --quiet)

lint:
	@echo "$(YELLOW)$(BOLD)  Running linter...$(RESET_COLOR)"
	$(shell cargo clippy --quiet)

test:
	@echo "$(GREEN)$(BOLD)    Running Rust tests...$(RESET_COLOR)"
	$(eval TEST_OUTPUT := $(shell script -q -c "cargo test --quiet 2>/dev/null" /dev/null | grep -E '^test result'))
	@echo "    $(TEST_OUTPUT)"

run:
	@echo "$(RED)$(BOLD)Running the Rust program...$(RESET_COLOR)"
	$(eval RUN_OUTPUT := $(shell cargo run --quiet))
	@echo "$(RUN_OUTPUT)"

release:
	@echo "$(BOLD)Building in release mode...$(RESET_COLOR)"
	$(shell cargo build --release)

all: format lint test run
	@echo "$(RESET_COLOR)$(BOLD)All tasks completed.$(RESET_COLOR)"
