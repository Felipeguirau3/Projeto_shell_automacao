# =====================================================================
# Verificador Automático de Atualizações (Background)
# =====================================================================

REPOS=("/home/felip/Projeto_shell_automacao")
BRANCH="main"
LOCK_FILE="/tmp/repo_update.lock"

if [ -f "$LOCK_FILE" ]; then
    exit 0
fi
touch "$LOCK_FILE"
trap 'rm -f "$LOCK_FILE"' EXIT

for REPO_DIR in "${REPOS[@]}"; do
    FLAG_FILE="$REPO_DIR/.update_pending"
    LOG_DIR="$REPO_DIR/logs"
    LOG_FILE="$LOG_DIR/update.log"

    mkdir -p "$LOG_DIR"
    
    if [ ! -d "$REPO_DIR/.git" ]; then
        echo "[$(date)] ERRO: $REPO_DIR não é um repositório Git válido." >> "$LOG_FILE"
        continue
    fi

    cd "$REPO_DIR" || continue
    echo "[$(date)] Verificando atualizações..." >> "$LOG_FILE"

    git fetch origin --quiet

    LOCAL_COMMIT=$(git rev-parse HEAD)
    REMOTE_COMMIT=$(git rev-parse origin/$BRANCH)

    if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
        echo "[$(date)] Atualização encontrada para o commit $REMOTE_COMMIT." >> "$LOG_FILE"
        if [ ! -f "$FLAG_FILE" ]; then
            echo "$REMOTE_COMMIT" > "$FLAG_FILE"
        fi
    else
        echo "[$(date)] Repositório já está atualizado." >> "$LOG_FILE"
    fi
done