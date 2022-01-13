*** Settings ***
Library           SeleniumLibrary
Library           DebugLibrary
library           FakerLibrary

*** Variables ***

@{NUMEROS}    Numero1   Numero2   Numero3   Numero4   Numero5   Numero6   Numero7   Numero8   Numero9   Numero10



*** KeyWords ***

Percorrer lista usando FOR
    Log To Console    ${\n}
    FOR   ${NUMEROAGORA}   IN    @{NUMEROS}
        # Log To Console    Meu Número atual é: ${NUMEROAGORA}!
    IF  '${NUMEROAGORA}' == 'Numero5'
        Log To Console    Eu sou o Número 5!
      ELSE IF   '${NUMEROAGORA}' == 'Numero10'
        Log To Console    Eu sou o Número 10!
        ELSE
          Log To Console    Eu não sou o número 5 e nem o 10!

          END
          END
