*** Settings ***   
Resource          ./labs/common.resource
Suite Setup       Open Browser And Maximize Window
Test Setup        Go To Website    
Suite Teardown    Close All Browsers


*** Test Cases ***
login_failure
    Login To Website Using Wrong Credentials

succesful_login
    Succesful Login To Website   

check_dashboard
    Count And Check Dashboard Widgets

check_menu 
   Count And Check Menu Items

write_and_delete_post
    Write Post And Then Delete It

logout
    Logout User