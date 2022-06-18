*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             JSONLibrary

***Variables***
${URL_JIRA}                  https://tcrb-digitalprojects.atlassian.net
${jira_user}                 jirath.e@tcrbank.com          
${jira_password}             73x1Yhu7CoBWYS48aPPqEDC0

*** Keywords ***
Update_Jira_Status
    # [Arguments]         ${jira_action_card_number}
    Run Keyword If          '${TEST STATUS}' == 'PASS'        JiraStatus_Pass           #${jira_action_card_number}
    ...      ELSE IF        '${TEST STATUS}' == 'FAIL'        JiraStatus_Fail           #${jira_action_card_number}

JiraStatus_Pass
    # [Arguments]         ${jira_card_number}
    @{auth}=                Create List     ${jira_user}      ${jira_password}  
    Create Session          alias=JIRA             url=${URL_JIRA}       auth=${auth}
    ${body}=           To Json         {"transition": "11"}
    ${response}=       POST On Session         alias=JIRA         url=/rest/api/2/issue/${JIRA_CARD_NUMBER}/transitions       json=${body}        expected_status=anything

JiraStatus_Fail
    # [Arguments]         ${jira_card_number}
    @{auth}=                Create List     ${jira_user}      ${jira_password}  
    Create Session          alias=JIRA             url=${URL_JIRA}       auth=${auth}
    ${body}=           To Json         {"transition": "21"}
    ${response}=       POST On Session         alias=JIRA         url=/rest/api/2/issue/${JIRA_CARD_NUMBER}/transitions       json=${body}        expected_status=anything
