*** Settings ***   
Resource          ./labs/common.resource 
Suite Setup       Open Browser And Maximize Window And Login 
Suite Teardown    Close All Browsers 
Library           DataDriver   ./lib/data.xlsx
Test Template     Click On Menu Page And Check Header


*** Test Cases ***
Click_on_the_page_${menuPage}_and_check_header_${expectedHeader}   Default    Userdata    


*** Keywords ***
Click On Menu Page And Check Header
    [Documentation]    This keyword clicks one by one on certain menu pages' names imported from given xlsx file
    ...    and checks if their header are as expected headers imported from xlsx file
    [Arguments]   ${menuPage}   ${expectedHeader}   ${menuNavigator}=//span[text()="${menuPage}"]    
    ...           ${properHeader}=//h6[contains(text(),${expectedHeader})]
    Wait For Element And Click    ${menuNavigator}
    Input Password For Password Protected Page   ${menuPage}    ${EXCEPTION_NAME}  ${PASSWORD} 
    Wait For Element    ${properHeader} 

Input Password For Password Protected Page
    [Documentation]   This keyword checks if page is the named password protected page and inputs password
    [Arguments]    ${menuPage}   ${EXCEPTION_NAME}  ${password}
    Run Keyword If    "${menuPage}" == "${EXCEPTION_NAME}"    Wait Until Element Is Visible    ${PASSWORD_FIELD}    10s    0.1s
    Run Keyword If    "${menuPage}" == "${EXCEPTION_NAME}"    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Run Keyword If    "${menuPage}" == "${EXCEPTION_NAME}"    Click Button    ${SUBMIT_BUTTON}
    

*** Variables ***
${EXCEPTION_NAME}    Maintenance
${PASSWORD}   admin123
