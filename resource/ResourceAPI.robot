*** Settings ***
Documentation  Documentação da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Library        RequestsLibrary
Library        Collections
Library        BuiltIn

*** Variable ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1

&{BOOK_15}        id=15     title=Book 15                     pageCount=1500

&{BOOK_CREATE}    id=2022   title=Teste   description=Teste   pageCount=200                         excerpt=Teste                       publishDate=2017-01-13T05:58:57.312Z

&{BOOK_PUT}       id=150    title=TestePUT                    description=PUTCORRETO                pageCount=200   excerpt=PUT         publishDate=2022-01-13T11:25:29.061Z


*** Keywords ***

Conectar a minha API

    Create Session    fakeAPI    ${URL_API}



Requisitar todos os livros
    ${RESPOSTA}   GET On Session    fakeAPI    /Books  expected_status=any
    Log           ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}   GET On Session    fakeAPI    /Books/${ID_LIVRO}  expected_status=any
    Log           ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}


Cadastrar um novo livro
    ${HEADERS}           create Dictionary                     content-type=application/json

    ${RESPOSTA}          POST On Session    fakeAPI       /Books    expected_status=anything
    ...                  data={"id":2022, "title":"Teste", "description":"Teste", "pageCount":200, "excerpt":"Teste", "publishDate":"2017-01-13T05:58:57.312Z"}
    ...                  headers=${HEADERS}
    Log                  ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Alterar livro "150"
    ${HEADERS}          Create Dictionary                       content-type=application/json
    ${RESPOSTA}         PUT On Session    fakeAPI    /Books/5   expected_status=anything
    ...                 data={"id": 150, "title":"TestePUT", "description":"PUTCORRETO", "pageCount":200, "excerpt":"PUT", "publishDate":"2022-01-13T11:25:29.061Z"}
    ...                 headers=${HEADERS}
    Log                 ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Deletar o livro "200"
    ${RESPOSTA}          DELETE On Session    fakeAPI    /Books/200  expected_status=anything
    Log                  ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}


Conferir o status code
    [Arguments]   ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]   ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros

    Length Should Be    ${RESPOSTA.json()}      ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15

    Dictionary Should Contain Item    ${RESPOSTA.json()}    id               ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title            ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount        ${BOOK_15.pageCount}
    Should Not Be Empty               ${RESPOSTA.json()["description"]}
    Should Not Be Empty               ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty               ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados para o novo livro

    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_CREATE.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_CREATE.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description    ${BOOK_CREATE.description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_CREATE.pageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt        ${BOOK_CREATE.excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate    ${BOOK_CREATE.publishDate}

Conferir se retorna todos os dados alterados do livro "150"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_PUT.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_PUT.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description    ${BOOK_PUT.description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_PUT.pageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt        ${BOOK_PUT.excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate    ${BOOK_PUT.publishDate}

Conferir se deleta o livro "200"
  Should Be Empty    ${RESPOSTA.content}
