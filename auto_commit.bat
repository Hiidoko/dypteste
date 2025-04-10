@echo off
cd /d "C:\Users\Caio Marques\Desktop\newdyp"

REM Habilita variáveis com delay
setlocal EnableDelayedExpansion

REM Caminho do arquivo que guarda o índice atual
set "indexFile=commit_index.txt"

REM Se não existir o arquivo, cria com valor 1
if not exist "%indexFile%" (
    echo 1 > "%indexFile%"
)

REM Lê o índice atual
set /p index=<%indexFile%

REM Lista de mensagens de commit
set "msg[1]=Atualizações de segurança"
set "msg[2]=Mudanças de validade"
set "msg[3]=Automatização login"
set "msg[4]=Subindo alterações de segurança licenças"
set "msg[5]=Aumentando capacidade de login"
set "msg[6]=Acrescentado json para localhost de licenças"

REM Número total de mensagens
set total=6

REM Verifica se índice é válido
if "%index%"=="" set index=1

REM Pega a mensagem atual
for /L %%i in (1,1,%total%) do (
    if "!index!"=="%%i" set "commitMsg=!msg[%%i]!"
)

REM Confirma que temos uma mensagem
if "!commitMsg!"=="" (
    echo Erro: Mensagem de commit não encontrada para índice %index%
    exit /b 1
)

REM Executa os comandos git
git add .

REM Verifica se há mudanças para comitar
git diff --cached --quiet
if %errorlevel%==0 (
    echo Nenhuma mudança para comitar.
) else (
    git commit -m "!commitMsg!"
    git push origin master
)

REM Incrementa o índice
set /a index+=1

REM Volta ao início se passar do total
if %index% GTR %total% set index=1

REM Salva o novo índice
echo %index% > "%indexFile%"
