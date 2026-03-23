*** Settings ***
Library    SeleniumLibrary    run_on_failure=NOTHING
Library    OperatingSystem

Resource    ../data/common_properties.robot
Resource    ../data/testdata/stage/stage_testdata.robot
Resource    ../data/testdata/stage/login_testdata.robot
Resource    ../data/testdata/prod/prod_testdata.robot

*** Keywords ***

Set Up Web Test Environment
    [Documentation]    Create screenshots directory and configure browser for test run
    Create Directory    screenshots
    Set Selenium Speed    0.1s

Open Dashboard In Browser
    [Documentation]    Open browser and navigate to dashboard login page
    [Arguments]        ${env}=STAGING    ${country}=INDIA
    IF    '${env}' == 'STAGING' and '${country}' == 'INDIA'
        Open Browser    ${stage_url_india}    ${BROWSER}
    ELSE IF    '${env}' == 'STAGING' and '${country}' == 'KENYA'
        Open Browser    ${stage_url_eu}    ${BROWSER}
    ELSE IF    '${env}' == 'PROD' and '${country}' == 'INDIA'
        Open Browser    ${prod_url_india}    ${BROWSER}
    ELSE IF    '${env}' == 'PROD' and '${country}' == 'KENYA'
        Open Browser    ${prod_url_eu}    ${BROWSER}
    ELSE
        Fail    Invalid environment/country combination: ${env}/${country}
    END
    Maximize Browser Window
