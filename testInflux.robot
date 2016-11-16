*** Settings ***
Resource  ucInflux.robot

*** Variables ***
${host}     http://localhost:8082
${browser}  chrome
${user}     admin
${pass}     admin

&{Michael}   Titel=Prof.  Vorname=Michael  Nachname=Baumert  Email=Michael.Baumert@Adesso.de  Website=https://profiler.adesso.de/  Organisation=adesso AG  Strasse=Rotherstraße 19  PLZ=10245  Wohnort=Berlin  Land=Deutschland

*** Keywords ***
Pruefe, dass die Benutzerprofilseite angezeigt wird
    [Documentation]  Für aktuelle Webseite wird geprüft, ob es sich um die Benutzerprofilseite handelt
    [Arguments]  ${Benutzername}
    Wait Until Page Contains Element  xpath=//h2[@data-i18n="profile"]
    Page Should Contain Element  xpath=//*[@id="profile-info-admin"]//h2[contains(text(), "${Benutzername}")]

Benutzer bei influx einloggen
    [Documentation]  Einloggen bei in|FLUX als Benuzter mit Passwort
    [Arguments]  ${Benutzername}  ${Passwort}
    Go To  http://localhost:8082/influx/login
    Wait Until Page Contains Element  xpath=//form[@action="login-check"]  timeout=60
    Input Text  xpath=//form[@action="login-check"]//input[@name="name"]  ${Benutzername}
    Input Text  xpath=//form[@action="login-check"]//input[@name="pass"]  ${Passwort}
    Submit Form
    Pruefe, dass die Benutzerprofilseite angezeigt wird  ${Benutzername}

*** Test Cases ***
Oeffne Browser
    Open Browser  ${host}  ${browser}

Als Benutzer bei in|FLUX einloggen
    Benutzer bei influx einloggen  ${user}  ${pass}

Suche den Kontakt Thomas Ambrosius
    Suche nach Kontakt  Ambrosius

Lege den Kontakt Michael Baumert neu an
    Lege neuen Kontakt an  &{Michael}

Schliesse Browser
    Close Browser
