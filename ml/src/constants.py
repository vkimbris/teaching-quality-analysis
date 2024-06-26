CLASSIFIER_MODEL_PATH = "vkimbris/messages-analyzer-multilabel"
CLASSIFIER_MODEL_LABELS_MAPPING = {
    "technical_difficulties": "Технические неполадки",
    "swearing": "Ругательство",
    "difficulty_level": "Сложности в понимании",
    "everything_ok": "Все отлично"
}

DATABASE_SERVER_URL = "http://database:8000"

EXPLAINER_REPO_ID = "gromoboy/gemma_gguf_v2"
EXPLAINER_MODEL_NAME = "gemma_gguf_v2-unsloth.Q4_K_M.gguf"
EXPLAINER_THRESHOLD = 0.3

CATEGORY_THRESHOLD = 0.3

MARKS_MAPPING = {
    "Технические неполадки": "Техническая организация",
    "Ругательство": "Дисциплина",
    "Сложности в понимании": "Понятность изложения",
    "Все отлично": "Удовлетворенность студентов"
}
