*** Settings ***
Library           SeleniumLibrary
Library           DebugLibrary
library           FakerLibrary

*** Variables ***
${BROWSER}     gc
${URL}         http://automationpractice.com/
${IMAGEMLINK}  http://automationpractice.com/img/p/7/7-home_default.jpg
${NOME}        Teste
# &{Pessoa}      Nome=May  SobreNome=Fernandes  Senha=123456  Endereço= Rua Framework, Bairro Robot  Cidade=Floripa  CaixaPostal=12345  NumeroTelefone=99988877
# Input Text    id=customer_firstname ${Pessoa.Nome}
# Input Text    id=customer_lastname  ${Pessoa.SobreNome}
# Input Text    id=passwd             ${Pessoa.Senha}
# Input Text    id=address1           ${Pessoa.Endereço}
# Input Text    id=city               ${Pessoa.Cidade}
# Input Text    id=postcode           ${Pessoa.CaixaPostal}
# Input Text    id=phone+mobile       ${Pessoa.NumeroTelefone}
# @{Listas}       Printed Summer Dress    Printed Summer Dress    Printed Chiffon Dress
# Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[1]/div[2]/h5/a[@title="${Listas[0]}"]
# Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[1]/div[2]/h5/a[@title="${Listas[1]}"]
# Page Should Contain Element    xpath=//*[@id="center_column"]/ul/li[1]/div[2]/h5/a[@title="${Listas[2]}"]
# ${EMAIL}    CS233NS
# &{Pessoa}      Nome=Victor  SobreNome=Hugo    Emailteste=@testerobot.com

# Keyword teste
#   Informar um email válido ${Pessoa.nome}  ${Pessoa.SobreNome}
#   Log ${Mensagem}  ${Pessoa.Emailteste}
#
# Subkeyword teste
#   [Arguments]   ${NOMEUSUARIO}    ${SobreNomeUsuario}
#   Log    Nome Usuário: ${NOMEUSUARIO}
#   Log    Sobrenome: ${SobrenomeUsuario}




*** Keywords ***
#### Setup e Teardown

# Keyword teste
#   Informar um email válido    ${Pessoa.Nome}  ${Pessoa.SobreNome}
#   Log    ${Mensagem}${Pessoa.Emailteste}
#
# Informar um email válido
#   [Arguments]     ${NOME_USUARIO}   ${SOBRENOME_USUARIO}
#   ${Mensagem}     Log    Email:  ${NOME_USUARIO}${SOBRENOME_USUARIO}${EMAIL}
#   [Return]     ${Mensagem}

Abrir navegador
      Open Browser    about:blank  ${BROWSER}

Fechar navegador
      Close Browser

#### Passo-a-Passo
Acessar a página home do site
      Go To    http://automationpractice.com/
      Title Should Be    My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
      Input Text                       id=search_query_top    ${PRODUTO}

Clicar no botão pesquisar
      Click Element                    name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
      Wait Until Element Is Visible    xpath=//*[@id="center_column"]//*[@src="${IMAGEMLINK}"]
      Title Should Be                  Search - My Store
      Page Should Contain Link         xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]


Conferir mensagem de erro "${SEMRESULTADOS}"
      Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p
      Element Text Should Be           xpath=//*[@id="center_column"]/p    ${SEMRESULTADOS}

Passar o mouse por cima da categoria "${PRODUTO}" no menu principal superior de categorias
      Mouse Over                       xpath=//*[@id="block_top_menu"]//a[@title="${PRODUTO}"]
      Wait Until Element Is Visible    xpath=//*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a

Clicar na sub categoria "${PRODUTO}"
      Click Element                    xpath=//*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a
      Wait Until Element Is Visible    xpath=//*[@id="center_column"]//span [@class="category-name"][contains(text(),"${PRODUTO}")]

Clicar no botão "${PRODUTO}" do produto.
      Click Element                    xpath=//*[@id="center_column"]/ul/li/div/div[2]/div/a[1][@title="${PRODUTO}"]

Clicar no botão "${PRODUTO}"
      Wait Until Element Is Visible    xpath=//*[@id="layer_cart"]//a[@title="${PRODUTO}"]
      Click Element                    xpath=//*[@id="layer_cart"]//a[@title="${PRODUTO}"]
      Title Should Be                  Order - My Store

Clicar no ícone carrinho de compras no menu superior direito
      Click Element                    xpath=//*[@id="header"]//a[@title="View my shopping cart"]
      Title Should Be                  Order - My Store

Clicar no botão de remoção de produtos (delete) no produto do carrinho
      # Click Element                    xpath=//*[@id="5_19_0_0"]
      Element Text Should Be           xpath=//*[@id="center_column"]/p    Your shopping cart is empty.

Clicar no botão superior direito "${PRODUTO}"
      Click Element                    xpath=//*[@id="header"]//a[@class="login"]
      Title Should Be                  Login - My Store

Inserir um e-mail válido
      ${EMAIL}    FakerLibrary.Email
      Input Text                       xpath=//*[@id="email_create"]  ${EMAIL}

Clicar no botão de "${PRODUTO}"
      Click Element                    xpath=//*[@id="SubmitCreate"]/span
      Wait Until Element Is Visible    xpath=//*[@id="noSlide"]/h1

Preencher os campos obrigatórios
      Wait Until Element Is Visible     xpath=//*[@id="uniform-id_gender1"]
      Click Element                     xpath=//*[@id="uniform-id_gender1"]
      Input Text                        xpath=//*[@id="customer_firstname"]      teste
      Input Text                        xpath=//*[@id="customer_lastname"]       testeteste
      Input Text                        xpath=//*[@id="passwd"]                  teste123
      click element                     xpath=//option[contains(text(),'27')]
      click element                     xpath=//option[contains(text(),'January')]
      click element                     xpath=//option[contains(text(),'1999')]
      Input Text                        xpath=//*[@id="company"]                 Testandocompany
      Input Text                        xpath=//*[@id="address1"]                TestantoAddress
      Input Text                        xpath=//*[@id="address2"]                TestandoAdressline2
      Input Text                        xpath=//*[@id="city"]                    TestandoCity
      click element                     xpath=//option[contains(text(),'Alaska')]
      Input Text                        xpath=//*[@id="postcode"]                00000
      click element                     xpath=//option[contains(text(),'United States')]
      Input Text                        xpath=//*[@id="phone"]                   99999
      Input Text                        xpath=//*[@id="phone_mobile"]            9999999
      Click Element                     xpath=//*[@id="submitAccount"]

Clicar em "Register" para finalizar o cadastro
      Input Text                        xpath=//*[@id="alias"]                  teste22
      Title Should Be                   My Account - My Store
