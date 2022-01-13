*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}        http://automationpractice.com/
${BROWSER}    chrome

*** Test Case ***
Caso de Teste 01: Pesquisar produto existente
    dado que estou na página home do site
    quando eu pesquisar pelo produto "Blouse"
    então o produto "Blouse" deve ser listado na página de resultado da busca



Caso de Teste 02: Pesquisar produto não existente

  dado que estou na página home do site
  quando eu pesquisar pelo produto "itemNãoExistente"
  então a página deve exibir a mensagem "No results were found for your search "itemNãoExistente""


*** Keywords ***
