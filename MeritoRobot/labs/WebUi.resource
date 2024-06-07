*** Settings ***
Resource    ../labs/lab1.resource  
Resource    ./common.resource

*** Keywords ***
Open Browser And Maximize Window
    [Documentation]    This keyword opens given browser and maximizes its window
    Open Browser    ${WEBSITE}  browser=${BROWSER}
    Maximize Browser Window

Go To Website
    [Documentation]    This keywords opens given website
    Go To    ${WEBSITE} 

Wait For Element
    [Documentation]    This keyword waits stated time for an element based on its location
    [Arguments]    ${element}
    Wait Until Page Contains Element    ${element}    10s    0.1s

Wait For Element And Click
    [Documentation]    This keyword waits stated time for an element based on its location
    ...            then it clicks this element
    [Arguments]    ${element}
    Wait Until Page Contains Element    ${element}
    Click Element    ${element}

Wait For Text
    [Documentation]    This keyword waits stated time until page contains certain text
    [Arguments]    ${expectedExpression}
    Wait Until Page Contains    ${expectedExpression}    10s    0.1s    

Login To Page
    [Documentation]    This keyword log to website by entering username, password and clicking submit button
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_FIELD}    ${username} 
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button     ${SUBMIT_BUTTON}
    
Login To Website Using Wrong Credentials
    [Documentation]    This keyword logs to page using wrong credentials and waits for error messsage
     [Arguments]     ${expectedExpression}=Invalid credentials     ${username}=invalid     ${password}=invalid 
     Wait For Element    ${SUBMIT_BUTTON}     
     Login To Page    ${username}    ${password}     
     Wait For Text     ${expectedExpression}

Succesful Login To Website
     [Documentation]     This keyword logs to website and checks login by waiting for certain text on the website
     [Arguments]     ${element}=Dashboard    ${username}=Admin    ${password}=admin123
     Wait For Element    ${SUBMIT_BUTTON}     
     Login To Page    ${username}    ${password}     
     Wait For Text    ${element}

Count elements
    [Documentation]     This keyword counts elements of certain kind determined by their locator
    [Arguments]    ${element}
    Wait For Element    ${element}
    ${countedElements}    Get Element Count    ${element}
    RETURN     ${countedElements}

Count And Check Dashboard Widgets
     [Documentation]     This keyword iterates through a list of counted widgets and compares
     ...    list of their names with a given list of expected names
     [Arguments]    ${widgetHeader}=//div[@class="orangehrm-dashboard-widget-header"]
     ${countedWidgets}     Count elements    ${widgetHeader}
     ${countedWidgets}  Evaluate     ${countedWidgets}+1
     VAR     @{dashboardWidgets}
     FOR     ${i}    IN RANGE    1    ${countedWidgets}
      ${widgetName}    Get Text    //div[contains(@class, "orangehrm-dashboard-grid")]/div[${i}]//div/div[@class="orangehrm-dashboard-widget-header"]
      Append To List    ${dashboardWidgets}    ${widgetName}
    END
    Log List    ${dashboardWidgets}
    Lists Should Be Equal    ${dashboardWidgets}    ${expectedWidgets}
       
Count And Check Menu Items 
    [Documentation]    This keyword iterates through a list of counted menu items and compares
    ...    list of their names with a given list of expected names, it needs a sepcific xpath
    ${countedItems}    Count elements    ${MAIN_MENU_ELEMENT}  
    ${countedItems}    Evaluate    ${countedItems}+1
    VAR    @{menuItems}
    FOR    ${i}    IN RANGE    1    ${countedItems} 
      ${itemName}    Get Text    //li[contains(@class, "oxd-main-menu-item-wrapper")][${i}]/a[1]/span
      Append To List    ${menuItems}    ${itemName}
    END            
    Log List    ${menuItems}
    Lists Should Be Equal    ${menuItems}    ${expectedMenuItems}

Wait For Location And Click Image
    [Documentation]    This keyword waits to locate given image and then clicks on it
    [Arguments]    ${image}
    Wait Until Keyword Succeeds    10s    0.1s    Locate    ${image}
    ImageHorizonLibrary.Click Image    ${image}

Write Post And Then Delete It
    [Documentation]    This keyword goes to posting section, inputs and posts text then delets it
    [Arguments]    ${text}=Szczebrzeszyn-209345-!!!???@ 
    Set Reference Folder    ${REFERENCE_FOLDER}
    set confidence    0.7
    Run Keywords    Go To Posting Section    Write And Post Something    Delete Post    

Go To Posting Section
    [Documentation]    This keyword takes to the posting section on the website
    [Arguments]    ${button}=buzz.png     ${header}=Buzz Newsfeed  
    Wait For Location And Click Image    ${button}    
    Wait For Text    ${header}
    Sleep    2s

Write And Post Something
    [Documentation]    This keyword writes some text and then posts it
    [Arguments]    ${postButton}=post.png    ${location}=//textarea 
    Input Text    ${location}    ${TEXT}
    Wait For Location And Click Image    ${postButton}
    Sleep    2s
    Wait For Text    ${TEXT}
    
Delete Post
    [Documentation]    This keyword deletes previously written text and checks if it's deleted
    [Arguments]    ${deleteButton}=deletePost.png    ${confirmationButton}=yesDelete.png
    ...        ${moreOptionsButton}=(//i[@class="oxd-icon bi-three-dots"])[1]
    Wait For Element And Click    ${moreOptionsButton}
    Wait For Location And Click Image    ${deleteButton} 
    Wait For Location And Click Image    ${confirmationButton}    
    Wait Until Page Does Not Contain    ${TEXT}    10s    0.1s  

Logout User
    [Documentation]    This keyword logs out and checks if the logout succeeded
    [Arguments]    ${userOptions}=//p[@class='oxd-userdropdown-name']    ${logoutButton}=//a[@href="/web/index.php/auth/logout"]
    Wait For Element And Click    ${userOptions}    
    Wait For Element And Click    ${logoutButton}
    Wait For Element    ${SUBMIT_BUTTON}
    
Open Browser And Maximize Window And Login
    [Documentation]    This keyword opens browser, maximizes window and logs in
    Open Browser And Maximize Window
    Succesful Login To Website

