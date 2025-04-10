import subprocess
import time
import os
import itertools

# Caminho do seu repositório
REPO_PATH = r"C:\Users\Caio Marques\Desktop\newdyp"

# Mensagens de commit
commit_messages = [
    "Atualizações de segurança",
    "Mudanças de validade",
    "Automatização login",
    "Subindo alterações de segurança licenças",
    "Aumentado capacidade de login",
    "Acrescentado json para localhost de licenças"
]

# Gerador cíclico para manter a ordem
msg_cycle = itertools.cycle(commit_messages)

def run_git_commands():
    os.chdir(REPO_PATH)

    # Adiciona todas as mudanças
    subprocess.run(["git", "add", "."], shell=True)

    # Pega a próxima mensagem da lista
    commit_msg = next(msg_cycle)

    # Faz commit com a mensagem
    result = subprocess.run(["git", "commit", "-m", commit_msg], shell=True)

    # Verifica se houve algo para commitar
    if result.returncode == 0:
        subprocess.run(["git", "push", "origin", "master"], shell=True)
        print(f"✔ Commit feito com mensagem: {commit_msg}")
    else:
        print("⚠ Nada novo para commitar. Esperando o próximo ciclo...")

print("🕒 Auto push rodando a cada 3 horas. Pressione Ctrl+C para parar.")
while True:
    run_git_commands()
    time.sleep(3 * 60 * 60)  # Espera 3 horas
