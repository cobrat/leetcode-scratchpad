# 定义 Python解释器
PYTHON = python3

# 定义文件路径
SRC = leetcode.py
INPUT = input.txt
OUTPUT = output.txt
SOL_DIR = solutions

# 设置默认目标为 help
.DEFAULT_GOAL := help

# --- 参数处理逻辑 ---
# 这是一个技巧：如果第一个目标是 save，我们将后续的参数截获
ifeq (save,$(firstword $(MAKECMDGOALS)))
  # 获取第二个参数作为文件名 (e.g. "two_sum")
  SAVE_NAME := $(word 2, $(MAKECMDGOALS))
  # 为这个参数生成一个空规则，防止 make 报错说 "No rule to make target 'two_sum'"
  ifneq ($(SAVE_NAME),)
    $(eval $(SAVE_NAME):;@:)
  endif
endif

# --- 命令列表 ---

help:
	@echo "================ LeetCode Scratchpad ================"
	@echo "可用命令 (Available commands):"
	@echo "  make run             : 运行代码 (读取 input.txt -> 运行 leetcode.py -> 输出 output.txt)"
	@echo "  make save <name>     : 保存题解 (例如: make save two_sum)"
	@echo "  make commit          : 提交题解 (自动 git add solutions/ 并生成 commit log)"
	@echo "  make clean           : 重置环境 (清空 input/output/leetcode.py)"
	@echo "  make help            : 显示此帮助信息"
	@echo "====================================================="

# 运行代码
run:
	@echo "Running $(SRC) in ACM/Interview Mode..."
	@$(PYTHON) $(SRC) < $(INPUT) > $(OUTPUT)
	@echo "--- Output Content ---"
	@cat $(OUTPUT)
	@echo "\n----------------------"
	@echo "Done."

# 保存并重置
# 用法: make save two_sum
save:
	@if [ -z "$(SAVE_NAME)" ]; then \
		echo "错误: 请提供文件名。用法: make save <filename>"; \
		echo "示例: make save two_sum"; \
		exit 1; \
	fi
	@mkdir -p $(SOL_DIR)
	@cp $(SRC) $(SOL_DIR)/$(SAVE_NAME).py
	@echo "Saved $(SRC) to $(SOL_DIR)/$(SAVE_NAME).py"
	@make clean

# 提交 Solutions 到 Git
commit:
	@# 1. 添加 solutions 文件夹下的更改
	@git add $(SOL_DIR)
	@# 2. 获取暂存区的文件名，去掉路径和后缀，拼接成字符串
	@MSG=$$(git diff --cached --name-only $(SOL_DIR) | xargs -I {} basename {} .py | tr '\n' ',' | sed 's/,$$//' | sed 's/,/, /g'); \
	if [ -n "$$MSG" ]; then \
		echo "Committing with message: Add solution(s): $$MSG"; \
		git commit -m "Add solution(s): $$MSG"; \
	else \
		echo "solutions/ 目录下没有检测到新文件或更改，跳过提交。"; \
	fi

# 清理环境
clean:
	@echo "Clearing $(INPUT), $(OUTPUT) and $(SRC)..."
	@> $(INPUT)
	@> $(OUTPUT)
	@> $(SRC)
	@echo "Environment reset complete."

.PHONY: run save clean commit help
