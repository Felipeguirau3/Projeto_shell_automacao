# =====================================================================
# Aplicador de Atualizações com Rollback Automático
# =====================================================================

REPO_DIR="/home/felip/Projeto_shell_automacao"
BRANCH="main"
FLAG_FILE="${REPO_DIR}/.update_pending"
BACKUP_DIR="${REPO_DIR}/backups"
LOG_DIR="${REPO_DIR}/logs"
LOG_FILE="${LOG_DIR}/update.log"

if [ ! -f "$FLAG_FILE" ]; then
    echo "Nenhuma atualização pendente para o repositório."
    exit 0
fi

mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

cd "$REPO_DIR" || exit 1

echo "======================================="
echo " Nova atualização encontrada!"
echo " Commit remoto pendente:"
cat "$FLAG_FILE"
echo "======================================="
echo ""

while true; do
    read -p "Deseja aplicar a atualização agora? (y/n): " RESPONSE
    RESPONSE_LOWER="${RESPONSE,,}"
    
    if [ "$RESPONSE_LOWER" == "y" ] || [ "$RESPONSE_LOWER" == "n" ]; then
        break
    else
        echo "Opção inválida. Por favor, digite apenas 'y' para sim ou 'n' para não."
    fi
done

if [ "$RESPONSE_LOWER" != "y" ]; then
    echo "Atualização adiada pelo usuário."
    exit 0
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
CURRENT_COMMIT=$(git rev-parse HEAD)

echo "$CURRENT_COMMIT" > "$BACKUP_DIR/last_commit"
echo "[$(date)] Backup de segurança criado para o commit $CURRENT_COMMIT" >> "$LOG_FILE"
git diff > "$BACKUP_DIR/diff_$TIMESTAMP.patch"

echo "[$(date)] Executando git pull..." >> "$LOG_FILE"
git pull origin "$BRANCH" >> "$LOG_FILE" 2>&1

if [ $? -ne 0 ]; then
    echo "!! Erro crítico detectado durante o pull. Iniciando Rollback... !!"
    PREVIOUS_COMMIT=$(cat "$BACKUP_DIR/last_commit")
    git reset --hard "$PREVIOUS_COMMIT" >> "$LOG_FILE" 2>&1
    echo "Rollback concluído com sucesso. O ambiente foi restaurado."
    exit 1
fi

rm -f "$FLAG_FILE"

echo "[$(date)] Atualização aplicada com sucesso." >> "$LOG_FILE"
echo "Parabéns! Repositório atualizado com sucesso."