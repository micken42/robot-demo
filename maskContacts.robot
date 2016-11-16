*** Settings ***
Library  Selenium2Library

*** Keywords ***
Gehe zu Webseite Kontakte
    [Documentation]  Webseite Find Contacts wird aufgerufen
    Go To  http://localhost:8082/influx/contacts

Pruefe, dass die Webseite Kontakte angezeigt wird
    [Documentation]  Für aktuelle Webseite wird geprüft, ob es sich um die Webseite Kontakte handelt
    Page Should Contain Element  xpath=//h2[@data-i18n="contacts"]

Pruefe, dass die Webseite Kontakte verlassen wurde
    [Documentation]  Für aktuelle Webseite wird geprüft, ob es sich nicht um die Webseite Kontakte handelt
    Page Should Not Contain Element  xpath=//h2[@data-i18n="contacts"]

Pruefe, ob der Kontakt angezeigt wird
    [Arguments]  ${Nachname}
    [Documentation]  Es wird geprüft, ob der Kontakt auf der aktuellen Seite angezeigt wird
    Page Should Contain Element  xpath=//div[@class="contact-box"][//h5/strong[contains(text(), "Thomas Ambrosius")]]

Pruefe, dass das Kontaktformular angezeigt wird
    [Documentation]  Es wird geprüft, ob das Kontaktformular sichtbar ist
    Wait Until Page Contains Element  xpath=//div[@id="new-contact" and @aria-hidden="false"]//form[@id="contact-form"]

Rufe die Funktion Add Contact auf
    [Documentation]  Das Kontaktformular wird eingeblendet
    Click Element  xpath=//a[@data-toggle="modal" and @data-target="#new-contact"]

Gebe die Daten des neuen Kontaktes ein
    [Documentation]  Ein neuer Kontakt wird angelegt.
    [Arguments]   ${Titel}  ${Vorname}  ${Nachname}  ${Email}  ${Website}  ${Organisation}  ${Strasse}  ${PLZ}  ${Wohnort}  ${Land}
	Pruefe, dass das Kontaktformular angezeigt wird
	Sleep  1
    Input Text  name=Titel  ${Titel}
	Input Text  name=Vorname  ${Vorname}
	Input Text  name=Nachname  ${Nachname}
	Input Text  name=Email  ${Email}
	Input Text  name=Web  ${Website}
	Input Text  name=Organisation  ${Organisation}
	Input Text  name=Adresse-Straße  ${Strasse}
	Input Text  name=Adresse-PLZ  ${PLZ}
	Input Text  name=Adresse-Wohnort  ${Wohnort}
	Input Text  name=Adresse-Land  ${Land}

Sende das Add Contact Formular ab
    [Documentation]  Das Formular Add Contact wird abgeschickt und der Kontakt wird angelegt
	Submit Form

TK Suche nach Kontakt
    [Documentation]  Ein Besitzer wird gesucht. Für die Suche muss der Nachname des Besitzers eingegeben werden.
    [Arguments]  ${Nachname}
    Gehe zu Webseite Kontakte
    Pruefe, dass die Webseite Kontakte angezeigt wird
    Input Text  xpath=//form//input[@name="search"]  ${Nachname}
    Click Button  xpath=//form//button[i[@class="fa fa-search"]]
    Pruefe, ob der Kontakt angezeigt wird  ${Nachname}
