*** Variables ***
${WEBSITE}               https://opensource-demo.orangehrmlive.com
${BROWSER}               Firefox
${SUBMIT_BUTTON}         //button[@type="submit"]  
${USERNAME_FIELD}        //input[@name="username"] 
${PASSWORD_FIELD}        //input[@type="password"]
${MAIN_MENU_ELEMENT}     //li[contains(@class, "oxd-main-menu-item-wrapper")] 
${REFERENCE_FOLDER}      ./labs/images  
${TEXT}                  Szczebrzeszyn-172635-!!!??@@?
@{expectedWidgets}
...    Time at Work
...    My Actions
...    Quick Launch
...    Buzz Latest Posts
...    Employees on Leave Today
...    Employee Distribution by Sub Unit
...    Employee Distribution by Location
@{expectedMenuItems}
...    Admin
...    PIM
...    Leave
...    Time
...    Recruitment
...    My Info
...    Performance
...    Dashboard
...    Directory
...    Maintenance
...    Claim
...    Buzz