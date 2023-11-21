#!/bin/bash
########################################################################
#
#  Script for running nightly 5G/RC vNRC TGF run with custom GTE-main version
#
#  COPYRIGHT
#  ---------
#  Copyright (C) by
#  Ericsson AB
#  SWEDEN
#  Author : edenouz
#  Version: v0.2
#
########################################################################

# Parameters
NOW=$(date +"%Y-%m-%d-%H%M%S")
CURRENT_USER=$(whoami)
APP_NAME=$(basename $0 | sed "s/\.sh$//")
APP_VERSION="0.2"
HOSTNAME=$(hostname)

###################
# Basic Params
###################

# Directory location which will be created and where 5G/RC repo will be cloned (you need to have write permissions and folder should not be created !!) 
DEST_FOLDER="/repo/${CURRENT_USER}/nighty_${NOW}"

# Wanted GTE-main (GTECORE) version, RC Repo will be updated to build/use this version; If empty then use default
# Just specify number from "gte-main.25308", not full name
#GTE_CORE_VERSION=""
GTE_CORE_VERSION="25308"

###################
# TGF Suite Parameters (Most used ones; others are hardcoded or not implemented; doublecheck)
###################

# TGF Suite Location (this will add "suite <SUITE_LOCATION>" to TGF command)
SUITE_LOCATION="${DEST_FOLDER}/rc/test/suites/vnrc/ucr/mobility/mcpc_nr_sa_vnrc_SUITE.erl"

# TGF Test Group Parameter (this will add "tg <SUITE_TESTGROUP_PARAM>" to TGF command)
#SUITE_TESTGROUP_PARAM=""
SUITE_TESTGROUP_PARAM="sbt_soaking"

# TGF Passthough Parameter (this will add "passthrough <SUITE_PASSTHROUGH_PARAM>" to TGF command)
#SUITE_PASSTHROUGH_PARAM=""
SUITE_PASSTHROUGH_PARAM="-no_f1_hack"

# TGF mail receivers, if defined it will send TGF report to mail addresses (mail separated by ",")
# example: MAIL_ADDRESSES="name1.surname1@ericsson.com,name2.surname2@ericsson.com"
MAIL_ADDRESSES=""
#MAIL_ADDRESSES="vedran.major@ericsson.com,denis.ouzecki@ericsson.com"

###################
# Other Params
###################

# If defined it will checkout/cherrypick this commit after repo is cloned; copy command from gerrit
# NOTE: commit command should not have/cause merge conflicts
#CHERRYPICK_CHECKOUT_CMD="git fetch ssh://edenouz@gerrit.ericsson.se:29418/5g/rc refs/changes/95/9048195/10 && git checkout FETCH_HEAD"
CHERRYPICK_CHECKOUT_CMD=""

# Dont start TGF if DRY_RUN!="0" but just print TGF command, used for troubleshooting purposes
DRY_RUN="0"

###################
# Not Used Parameters
###################
DEBUG="0"


# -----------------------------------------------------------------------------
# Log functions
# -----------------------------------------------------------------------------
fn_log_info()  { echo "* $APP_NAME: $1"; }
fn_log_warn()  { echo "* $APP_NAME: [WARNING] $1" 1>&2; }
fn_log_error() { echo "* $APP_NAME: [ERROR] $1" 1>&2; }
fn_log_info_cmd()  {
    echo "* $APP_NAME: $1";
}

# -----------------------------------------------------------------------------
# Make sure everything really stops when CTRL+C is pressed
# -----------------------------------------------------------------------------
fn_terminate_script() {
    fn_log_info "SIGINT caught."
    exit 1
}
trap 'fn_terminate_script' SIGINT

# -----------------------------------------------------------------------------
# Run commands
# -----------------------------------------------------------------------------
fn_run_cmd() {
    eval $1
}

# -----------------------------------------------------------------------------
# Create mail template
# -----------------------------------------------------------------------------
fn_create_mail_template() {
    if [[ -z "${1}" ]]; then fn_log_error "Illegal call of function; Aborting"; exit 1; fi
    echo "Subject: Nightly Test Run on UP=%up" > ${1}
    echo "From: TGF results <noreply.tgf@ericsson.com>" >> ${1}
    echo "Recipients: ${MAIL_ADDRESSES}" >> ${1}
    echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">" >> ${1}
    echo "<html><body><br>" >> ${1}
    echo "%dtr" >> ${1}
    echo "<br></body></html>" >> ${1}
}

# -----------------------------------------------------------------------------
# Help printout; not implemented yet
# -----------------------------------------------------------------------------
fn_display_usage() {
    echo ""
    echo "Usage: $(basename $0) [OPTION]..."
    echo ""
    echo "Options: .... TO IMPLEMENT"
    echo ""
}


# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# SCRIPT START
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------


fn_log_info " **************************************************"
fn_log_info " * Running ${APP_NAME}, version ${APP_VERSION} "
fn_log_info " **************************************************"
fn_log_info ""

# -----------------------------------------------------------------------------
# Source Environment
# -----------------------------------------------------------------------------
fn_log_info "Source environment"
fn_run_cmd "source ~/.bash_profile"
fn_run_cmd "source ~/.bashrc"

# -----------------------------------------------------------------------------
# Check necessary params
# -----------------------------------------------------------------------------
fn_log_info "Check necessary params"
if [[ -z "${DEST_FOLDER}" ]]; then fn_log_error "DEST_FOLDER param empty or missing; Aborting"; exit 1; fi
if [[ -z "${SUITE_LOCATION}" ]]; then fn_log_error "SUITE_LOCATION param empty or missing; Aborting"; exit 1; fi

# -----------------------------------------------------------------------------
# Check if destination folder already exists
# -----------------------------------------------------------------------------
fn_log_info "Verify that folder ${DEST_FOLDER} does not exist"
if [ -n "$(find "${DEST_FOLDER}" -type d 2>/dev/null)" ]; then
    fn_log_error "Destination folder ${DEST_FOLDER} ALREADY EXIST - Aborting."
    exit 1
fi
# -----------------------------------------------------------------------------
# Create destination folder if it doesn't already exists
# -----------------------------------------------------------------------------
if [ -z "$(find "${DEST_FOLDER}" -type d 2>/dev/null)" ]; then
    fn_log_info "Creating destination folder : ${DEST_FOLDER}"
    fn_run_cmd "mkdir -p -- ${DEST_FOLDER}"
fi

# -----------------------------------------------------------------------------
# Clone 5g/rc repo
# -----------------------------------------------------------------------------
fn_log_info "Cloning 5G/RC repository into ${DEST_FOLDER}"
fn_run_cmd "cd ${DEST_FOLDER}"
#git clone 5g/rc
fn_run_cmd "/proj/lte_twh/x86_64-Linux2.6.16/ltetools/current/bin/clone_repo 5g/rc > /dev/null"
fn_log_info "Verify that ${DEST_FOLDER}/rc exist"
if [ -n "$(find "${DEST_FOLDER}/rc" -type d 2>/dev/null)" ]; then
    fn_log_info "Cloning of 5g/rc successful"
else
    fn_log_error "Cloning of 5g/rc NOT successful; Aborting"
    exit 1
fi
sleep 1
fn_run_cmd "cd rc"

# -----------------------------------------------------------------------------
# Checkout/Cherrypick if specified 
# -----------------------------------------------------------------------------
fn_log_info "Apply checkout/cherrypick if specified"
if [[ -z "${CHERRYPICK_CHECKOUT_CMD}" ]]; then
    fn_log_info "No cherrypick/checkout specified; skipping"
else
    fn_log_info "Trying to cherrypick/checkout with CMD:${CHERRYPICK_CHECKOUT_CMD}"
    fn_run_cmd "${CHERRYPICK_CHECKOUT_CMD}"
fi

# -----------------------------------------------------------------------------
# Update GTE baseline if GTE_CORE_VERSION is specified
# -----------------------------------------------------------------------------
if [[ -z "${GTE_CORE_VERSION}" ]]; then
    fn_log_info "No GTE_CORE specified; Using default GTE_CORE version"
else
    fn_log_info "Change GTE-main version to ${GTE_CORE_VERSION}"
    sed -i 's|-main.*.tgz|-main.'"${GTE_CORE_VERSION}"'.tgz|g' .baseline/data/test_meta.xml
    sed -i 's|/main.*/|/main.'"${GTE_CORE_VERSION}"'/|g' .baseline/data/test_meta.xml
    #cat .baseline/data/test_meta.xml
fi

# -----------------------------------------------------------------------------
# Older repo version have fsue in rebar which is not supported anymore by GTE; so remove it (probably this is obolete in newer repo's)
# -----------------------------------------------------------------------------
fn_log_info "Setup rebar"
sed -i '/fsue/d' gte/rebar.config
#cat gte/rebar.config

# -----------------------------------------------------------------------------
# Source gitenv.sh
# -----------------------------------------------------------------------------
fn_log_info "Source gitenv"
fn_run_cmd "source gitenv.sh"

# -----------------------------------------------------------------------------
# Build RC GTE & Fetch version
# -----------------------------------------------------------------------------
GTE_RC_VERSION=""
if [[ -z "${GTE_CORE_VERSION}" ]]; then
    fn_log_info "Skipping build of custom RC GTE version; Using official version"
else
    fn_log_info "Starting RC GTE Build (Log:/tmp/mct_build_${NOW}.txt)"
    fn_log_info "NOTE: This will take some time for build to finish"
    fn_log_info "************************** 5G/RC BUILD STARTED ****************************************"
    fn_run_cmd "mct-gte-build > /tmp/mct_build_${NOW}.txt "
    fn_log_info "************************** 5G/RC BUILD END ****************************************"
    sleep 2
    #cat /tmp/mct_build_${NOW}.txt
    GTE_RC_VERSION=$(cat /tmp/mct_build_${NOW}.txt | grep -oP '^GTE:\s+\K\S+')
    fn_log_info "GTE_RC_VERSION=${GTE_RC_VERSION}"
    sleep 1
    fn_run_cmd "rm /tmp/mct_build_${NOW}.txt"
    if [[ -z "${GTE_RC_VERSION}" ]]; then fn_log_error "GTE_RC_VERSION empty; Problem with build; Aborting"; exit 1; fi
fi

# -----------------------------------------------------------------------------
# Create TGF command from Params and run TGF
# -----------------------------------------------------------------------------
fn_log_info "Create MCT-JOB Command & Run Suite"
MCTJOB_COMMAND="/proj/lte_twh/tools/ltk/current/bin/mct-job vnrc,sds suite=${SUITE_LOCATION}"
if [[ -n "${SUITE_TESTGROUP_PARAM}" ]]; then MCTJOB_COMMAND="${MCTJOB_COMMAND} tg ${SUITE_TESTGROUP_PARAM}"; fi
if [[ -n "${SUITE_PASSTHROUGH_PARAM}" ]]; then MCTJOB_COMMAND="${MCTJOB_COMMAND} passthrough=\"${SUITE_PASSTHROUGH_PARAM}\""; fi
if [[ -n "${GTE_RC_VERSION}" ]]; then MCTJOB_COMMAND="${MCTJOB_COMMAND} custom_gte ${GTE_RC_VERSION} --latest"; fi
if [[ -n "${MAIL_ADDRESSES}" ]]; then
    fn_create_mail_template "/tmp/mct_mail_template.txt"
    MCTJOB_COMMAND="${MCTJOB_COMMAND} mail mailtemplate /tmp/mct_mail_template.txt"; 
fi

if [[ "${DRY_RUN}" -eq "0"  ]]; then
    fn_log_info "Running MCT-JOB/TGF suite";
    fn_log_info "MCT-JOB Command: ${MCTJOB_COMMAND}";
    fn_run_cmd "${MCTJOB_COMMAND}";
else
    fn_log_info "Dry Run: Just print MCT-JOB command:";
    fn_log_info "MCT-JOB Command: ${MCTJOB_COMMAND}";
fi

# -----------------------------------------------------------------------------
# Delete Repo
# -----------------------------------------------------------------------------
# IMPORTANT !!! This could be very dangerous if wrong
#sleep 10
#fn_run_cmd "cd ${DEST_FOLDER};cd.."
#fn_run_cmd "rm -rf ${DEST_FOLDER};pwd"
fn_log_info ""
fn_log_info " **************************************************"
fn_log_info " * Script Finished"
fn_log_info " **************************************************"
