#!/bin/bash

ARQUIVO="tarefas.txt"

touch $ARQUIVO

while true; do
    clear
    echo "===== Gerenciador de Tarefas ====="
    echo "1) Adicionar Tarefa"
    echo "2) Listar Tarefas"
    echo "3) Concluir Tarefa"
    echo "4) Remover Tarefa"
    echo "5) Sair"
    echo "=================================="
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            add_tarefas() {
                read -p "Adicione sua tarefa: " Tarefas
                # Adiciona a nova tarefa no topo de forma segura
                echo "$Tarefas" | cat - $ARQUIVO > temp && mv temp $ARQUIVO
                echo "Tarefa adicionada no topo!"
                sleep 1
            }
            add_tarefas
            ;;
        2)
            listar_tarefas() {
                if [ -s $ARQUIVO ]; then
                    cat $ARQUIVO
                    echo
                    read -n 1 -s -p "Pressione qualquer tecla para voltar ao menu..."
                else
                    echo "Nenhuma tarefa encontrada."
                    sleep 1
                fi
            }
            listar_tarefas
            ;;
        3)
            concluir_tarefa() {
                if [ -s $ARQUIVO ]; then
                    nl -ba $ARQUIVO
                    read -p "Qual tarefa você concluiu? (número da linha) " concluiu
                    sed -i "${concluiu}s/^/[CONCLUÍDA] /" $ARQUIVO
                    echo "Tarefa marcada como concluída!"
                    sleep 1
                else
                    echo "Nenhuma tarefa para concluir."
                    sleep 1
                fi
            }
            concluir_tarefa
            ;;
        4)
            remover_tarefa() {
                if [ -s $ARQUIVO ]; then
                    nl -ba $ARQUIVO
                    read -p "Qual linha da tarefa você quer excluir? " linha
                    sed -i "${linha}d" $ARQUIVO
                    echo "Tarefa removida!"
                    sleep 1
                else
                    echo "Nenhuma tarefa para remover."
                    sleep 1
                fi
            }
            remover_tarefa
            ;;
        5)
            echo "Saindo..."
            break
            ;;
        *)
            echo "Opção inválida!"
            sleep 1
            ;;
    esac
done
