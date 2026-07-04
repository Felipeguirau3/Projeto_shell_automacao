# Projeto_shell_automacao
Automatização de Tarefas com Scripts em Ambiente Linux e Controle de Versões usando Git e GitHub

# GitAutoUpdate - Sistema de Automação de Atualizações e Backups Dinâmicos

## Descrição do Projeto
Este projeto foi desenvolvido para a disciplina de Laboratório de Ferramentas de Programação da FT-Unicamp. Trata-se de uma ferramenta desenvolvida em Shell Script (Bash) projetada para automatizar o monitoramento de atualizações em repositórios Git locais. O sistema garante a integridade do ambiente de desenvolvimento ao gerar backups preventivos automáticos de alterações locais (.patch e stash) e disponibiliza mecanismos de rollback automático em caso de falhas críticas ou conflitos durante a sincronização (git pull).

## Objetivos
- Automatizar rotinas de gerenciamento e sincronização de repositórios em ambiente Linux.
- Garantir a salvaguarda do código local através de rotinas automáticas de backup antes de atualizações estruturais.
- Implementar conceitos práticos de manipulação do sistema de arquivos, variáveis especiais, estruturas condicionais (`if/else`) e laços de repetição (`for/while`).

## Integrantes do Grupo e Divisão de Funções
O grupo é composto por 4 integrantes, com as responsabilidades distribuídas da seguinte forma para garantir o desenvolvimento colaborativo:
- **Lucas Felipe Da Silva Lima:** Desenvolvimento do Script de Monitoramento em Background (`check_updates.sh`), manipulação de travas do sistema (`LOCK_FILE`) e lógica do laço de repetição `for` para varredura de múltiplos repositórios.
- **Rafael Pires De Melo Ferreira:** Desenvolvimento do Script Interativo (`apply_update.sh`), implementação do laço `while` para validação robusta de entradas do usuário, tratamento do arquivo de flag e engenharia da rotina de *rollback* automático.
- **Davi Camargo Matias Freitas:** Engenharia de DevOps, criação e administração do repositório público no GitHub, organização da estrutura de pastas, gerenciamento de branches e integração do controle de versões da equipe.
- **Felipe Guirau da Silva:** Consolidação do projeto, redação da documentação técnica (`README.md`), testes de estresse/validação do sistema e gravação/edição do vídeo final de apresentação da ferramenta.

## Instruções de Uso e Execução
Para testar e rodar a ferramenta em seu ambiente Linux, siga os passos abaixo:

1. Certifique-se de dar permissão de execução aos scripts contidos na pasta do projeto:
   ```bash
   chmod +x scripts/*.sh