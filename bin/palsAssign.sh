#!/bin/bash

IcmBriefDescription="Assignment Remote Operation For AAIS-ByStar"

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/core/bsip/bin/bisosAccounts.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*  /Controls/ ::  [[elisp:(org-cycle)][| ]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[file:Panel.org][Panel]] | [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] | [[elisp:(bx:org:run-me)][Run]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] [[elisp:(org-cycle)][| ]]
** /Version Control/ ::  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]]
####+END:
_CommentEnd_

_CommentBegin_
*      ================
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes         :: *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xrefs         :: *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Panel        :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Info          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]
_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Imports       :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_


# Import Libraries

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh


# ./platformBases_lib.sh
. ${opBinBase}/platformBases_lib.sh


. ${opBinBase}/bpo_lib.sh
. ${opBinBase}/bpoId_lib.sh

# ./lcnFileParams.libSh
. ${opBinBase}/lcnFileParams.libSh

# ./bystarInfoBase.libSh
#. ${opBinBase}/bystarInfoBase.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/site_lib.sh

. ${opBinBase}/sysChar_lib.sh

. ${opBinBase}/box_lib.sh

. ${palsBinBase}/palsAssign_lib.sh


# PRE parameters
typeset -t serviceType=""     # one of [HPV]
typeset -t fpsBase=""     # one of [MAPIS]

function G_postParamHook {

    lpCurrentsGet

    lpReturn 0
}

function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""

    local oneId=$(vis_thisBoxUUID)

    typeset examplesInfo="${extraInfo}"

    local assignsBase=$(vis_pals_registrarAssignBaseObtain)
    EH_assert [ ! -z "${assignsBase}" ]

    local boxId=$( siteBoxAssign.sh -i thisBoxFindId )
    #local containerBase=$( vis_withBoxIdFindContainerBase "${boxId}" )
    local containerBase=$( vis_forThisSysFindContainerBase )
    local containerNu=$( vis_fromContainerBaseGetContainerNu "${containerBase}" )    

    # local oneRealIndiv=$(cat /bxo/usg/bystar/bpos/real/realIndiv.bpoFp/value)

    local oneFpsBase=$(palsRealizationFPs.sh -p fpsRoot="~pip_palsDevExamples/realizationFPs" -p serviceType=ByDomain -p fqdnRoot=example.com -i realizationFPsProcess fpsBase)
    local oneAssignBase=$(vis_pals_forFpsBaseFindAssignBase ${oneFpsBase})


    visLibExamplesOutput ${G_myName}
    # ${doLibExamples} 
    cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Assignment Bases Information" )
${G_myName} ${extraInfo} -i pals_registrarBaseObtain
${G_myName} ${extraInfo} -i pals_registrarAssignBaseObtain
ls -ld ${assignsBase}/*
find ${assignsBase} -print
$( examplesSeperatorChapter "Containers Bases Initializations" )
${G_myName} ${extraInfo} -i pals_registrarBaseDirsCreate    # INITIALIZATION -- create basis for nu assignments
$( examplesSeperatorChapter "ServiceInitial To ServiceType Mapping" )
${G_myName} ${extraInfo} -i pals_withServiceLetterGetServiceType N # [NBFD]
${G_myName} ${extraInfo} -i pals_withServiceTypeGetServiceLetter ByName # ByName, BySmb, ByFamily, ByDomain
${G_myName} ${extraInfo} -i pals_withNuGetId 100001
${G_myName} ${extraInfo} -i pals_withIdGetAssignedBase ByN-100001 # [NBFD]
${G_myName} ${extraInfo} -p serviceType=ByName -i pals_withNuGetAssignedBase 100001
${G_myName} ${extraInfo} -i fromContainerBaseGetContainerNu "${containerBase}"
$( examplesSeperatorChapter "SET -- Assignment -- Primary Commands" )
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i pals_serviceTypeAssignToFpsBase
${G_myName} -f ${extraInfo} -p fpsBase=${oneFpsBase} -i pals_serviceTypeAssignToFpsBase # FORCED
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i pals_serviceTypeAssignToFpsBaseAndPush  # ASSIGN PRIMARY COMMAND
${G_myName} -f ${extraInfo} -p fpsBase=${oneFpsBase} -i pals_serviceTypeAssignToFpsBaseAndPush  # FORCED PRIMARY COMMAND
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i pals_assignUpdate_atNu 100001 # Internal
$( examplesSeperatorChapter "UNSET -- Container Box Un Assignment" )
${G_myName} ${extraInfo} -i pals_UnAssign palsBase
${G_myName} ${extraInfo} -i pals_UnAssignAndPush palsBase
$( examplesSeperatorChapter "GIT -- Synchronization" )
echo palsBase | bx-gitRepos -i addCommitPush all
${G_myName} ${extraInfo} -i aabos_ssignBasePull
$( examplesSeperatorChapter "GET -- Container Nu" )
${G_myName} ${extraInfo} -p serviceType=ByName -i pals_assignNuGetNext
${G_myName} ${extraInfo} -i pals_forFpsBaseFindAssignBase ${oneFpsBase}  # INFO PRIMARY COMMAND
${G_myName} -i pals_withAssignBaseReport ${oneAssignBase} # INFO PRIMARY COMMAND -- FPs-readDeep
$( examplesSeperatorChapter "GET -- Params" )
${G_myName} ${extraInfo} -i pals_withAssignBaseGet_fpsBase ${oneAssignBase}
${G_myName} ${extraInfo} -i pals_withAssignBaseGet_serviceType ${oneAssignBase}
${G_myName} ${extraInfo} -i pals_withAssignBaseGet_palsNu ${oneAssignBase}
${G_myName} ${extraInfo} -i pals_withAssignBaseGet_palsId ${oneAssignBase}
${G_myName} ${extraInfo} -i pals_withAssignBaseGet_palsBpoId ${oneAssignBase}
${G_myName} ${extraInfo} -i pals_withAssignBaseReadFileParam ${oneAssignBase} palsBpoId
_EOF_
}


noArgsHook() {
  vis_examples
}
