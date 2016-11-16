*** Settings ***
Library  Selenium2Library
Library  Collections
Resource  maskContacts.robot

*** Keywords ***
Suche nach Kontakt
    [Documentation]  Ein Besitzer wird gesucht. Für die Suche muss der Nachname des Besitzers eingegeben werden.
    [Arguments]  ${Nachname}
    Gehe zu Webseite Kontakte
    TK Suche nach Kontakt  ${Nachname}

Lege neuen Kontakt an
    [Documentation]  Ein neuer Kontakt wird angelegt.
    [Arguments]  &{Kontakt}
    Gehe zu Webseite Kontakte
    Rufe die Funktion Add Contact auf
    Gebe die Daten des neuen Kontaktes ein  &{Kontakt}
    Sende das Add Contact Formular ab
    Gehe zu Webseite Kontakte
    Suche nach Kontakt  &{Kontakt}[Nachname]


