*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  OperatingSystem
Library  RoboZap  http://192.168.0.223:8090/  8090
Library  OperatingSystem

*** Variables ***
${BROWSER}  headlessfirefox
${URL}  http://192.168.0.223:9000/
${ZAP_PATH}  /Applications/OWASP ZAP.app/Contents/Java/zap.sh
${ZAP_TARGET}  http://192.168.0.223:9000/
${CONTEXT}  SecDevOps
${REPORT_FORMAT}  json
${REPORT_TITLE}  ZAP Report
${REPORT_AUTHOR}  we45
${EXPORT_FILE_PATH}  ${CURDIR}/zap.json
${SCANPOLICY}  Light

*** Test Cases ***
Login to Wecare application
    open browser  ${URL}  ${BROWSER}
    set selenium implicit wait  10
    Maximize Browser Window
    Go To  ${URL}login/
    set selenium implicit wait  10
    Sleep  5
    input text  xpath=/html/body/div/div/section/form/div[1]/input  bruce.banner@we45.com
    set selenium implicit wait  10
    input text  xpath=/html/body/div/div/section/form/div[2]/input  secdevops
    set selenium implicit wait  10
    click Element  xpath=/html/body/div/div/section/form/div[3]/button
    set selenium implicit wait  10
    Sleep  5
    Go To  ${URL}technicians/
    set selenium implicit wait  10
    Sleep  5
    Go To  ${URL}appointment/plan
    set selenium implicit wait  10
    Sleep  5
    Go To  ${URL}appointment/doctor
    set selenium implicit wait  10
    Sleep  5
    Go To  ${URL}secure_tests/
    set selenium implicit wait  10
    Sleep  5
    input text  xpath=/html/body/div[2]/div/div[3]/form/div/input[1]  selenium test
    set selenium implicit wait  10
    Go To  ${URL}tests/
    set selenium implicit wait  10
    Sleep  5
    input text  xpath=/html/body/div[2]/div/div[3]/form/div/input[1]  selenium test
    set selenium implicit wait  10
    click Element  xpath=/html/body/div[2]/div/div[3]/form/div/input[2]
    set selenium implicit wait  10
    Go To  ${URL}plans
    set selenium implicit wait  10
    Sleep  2

Secure Password
    Go To  ${URL}password_change
    set selenium implicit wait  10
    Sleep  2
    input text  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[1]/div[2]/div/div/input  secdevops
    set selenium implicit wait  10
    input text  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[2]/div[2]/div/div/input  secdevops
    set selenium implicit wait  10
    click Element  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[3]/button
    set selenium implicit wait  10
    Go To  ${URL}password_change_secure
    set selenium implicit wait  10
    Sleep  2
    input text  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[1]/div[2]/div/div/input  secdevops
    set selenium implicit wait  10
    input text  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[2]/div[2]/div/div/input  secdevops
    set selenium implicit wait  10
    click Element  xpath=/html/body/div[2]/div/div[3]/div/div[2]/form/div[3]/button
    set selenium implicit wait  10
    Sleep  2

# Logout
#     click Element  xpath=/html/body/div[2]/div/div[2]/div/nav/ul/li/a
#     set selenium implicit wait  10
#     click Element  xpath=/html/body/div[2]/div/div[2]/div/nav/ul/li/ul/li[3]/a
#     set selenium implicit wait  10

Start ZAP
    start headless zap  ${ZAP_PATH}
    sleep  30
    zap open url  ${ZAP_TARGET}

ZAP Contextualize
    ${contextid}=  zap define context  ${CONTEXT}  ${ZAP_TARGET}
    set suite variable  ${CONTEXT_ID}  ${contextid}

ZAP Crawl
    ${spider_id}=  zap start spider  ${CONTEXT}  ${ZAP_TARGET}
    zap spider status  ${spider_id}
    sleep  30

ZAP Active Scan
    ${scan_id}=  zap start ascan  ${CONTEXT_ID}  ${ZAP_TARGET}  ${SCANPOLICY}
    sleep  5
    set suite variable  ${SCAN_ID}  ${scan_id}
    zap scan status  ${scan_id}

ZAP Generate Report
    zap export report  ${EXPORT_FILE_PATH}  ${REPORT_FORMAT}  ${REPORT_TITLE}  ${REPORT_AUTHOR}