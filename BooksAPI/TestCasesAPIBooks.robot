*** Settings ***
Documentation  Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Resource       ../resource/ResourceAPI.robot
Suite Setup    Conectar a minha API


*** Test Case ***
# TO-DO: Buscar a listagem de todos os livros (Get em todos os livros)
#     Requisitar todos os livros
#     Conferir o status code    200
#     Conferir o reason  OK
#     Conferir se retorna uma lista com "200" livros

# TO-DO: Buscar um livro específico (GET em umn livro específico)
#     Requisitar o livro "15"
#     Conferir o status code    200
#     Conferir o reason  OK
#     Conferir se retorna todos os dados corretos do livro 15
#
# TO-DO: Cadastrar um novo livro (POST)
#     Cadastrar um novo livro
#     Conferir se retorna todos os dados cadastrados para o novo livro
#
# TO-DO: Alterar um livro (PUT)
#       Alterar livro "150"
#       Conferir se retorna todos os dados alterados do livro "150"
#
TO-DO: Deletar um livro (DELETE)
    Deletar o livro "200"
    Conferir se deleta o livro "200"
