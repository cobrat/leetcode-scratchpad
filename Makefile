PYTHON = python3
SRC = leetcode.py
INPUT = input.txt
OUTPUT = output.txt
SOL_DIR = solutions

run:
	@echo "Running $(SRC) in ACM/Interview Mode..."
	@$(PYTHON) $(SRC) < $(INPUT) > $(OUTPUT)
	@echo "--- Output Content ---"
	@cat $(OUTPUT)
	@echo "\n----------------------"
	@echo "Done."

save:
ifndef n
	$(error Please specify a name using n=filename (e.g., make save n=huawei_01))
endif
	@mkdir -p $(SOL_DIR)
	@cp $(SRC) $(SOL_DIR)/$(n).py
	@echo "Saved $(SRC) to $(SOL_DIR)/$(n).py"
	@make clean

clean:
	@echo "Clearing $(INPUT), $(OUTPUT) and $(SRC)..."
	@> $(INPUT)
	@> $(OUTPUT)
	@> $(SRC)
	@echo "Environment reset complete."

.PHONY: run save clean
