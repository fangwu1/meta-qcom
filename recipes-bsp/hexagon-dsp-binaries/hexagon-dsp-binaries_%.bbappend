# PENDING: Maili MTP hexagon DSP binaries
# Binary source staged at Artifactory until maili is upstreamed to linux-msm/dsp-binaries.
# Once upstreamed:
# - Remove SRC_URI:append:maili-mtp and do_install:append:maili-mtp below
# - The remaining variables in hexagon-dsp-binaries.inc cover the rest

DSP_ARTIFACTORY = "artifactory-las.qualcomm.com/artifactory/lint-lv-local/firmware-artifacts"

DSP_PV_maili = "20260917"

SRC_URI:append:maili-mtp = " \
    https://${DSP_ARTIFACTORY}/maili-hexagon-dsp-binaries-${DSP_PV_maili}.zip;name=maili-dsp;subdir=hexagon-dsp-binaries-maili \
"
SRC_URI[maili-dsp.sha256sum] = "614e133aa823587df9fc95d99d19cf184a90ab3bf20e6dd53644840cf57d300a"

do_install:append:maili-mtp() {
    install -d ${D}${datadir}/qcom/maili/Qualcomm/Maili-MTP/dsp
    cp -r ${UNPACKDIR}/hexagon-dsp-binaries-maili/maili-hexagon-dsp-binaries-${DSP_PV_maili}/maili/Qualcomm/Maili-MTP/dsp/adsp \
        ${D}${datadir}/qcom/maili/Qualcomm/Maili-MTP/dsp/
    cp -r ${UNPACKDIR}/hexagon-dsp-binaries-maili/maili-hexagon-dsp-binaries-${DSP_PV_maili}/maili/Qualcomm/Maili-MTP/dsp/cdsp \
        ${D}${datadir}/qcom/maili/Qualcomm/Maili-MTP/dsp/

    install -d ${D}${datadir}/qcom/conf.d
    cat > ${D}${datadir}/qcom/conf.d/hexagon-dsp-binaries-qualcomm-maili-mtp.yaml << 'YAML_EOF'
# SPDX-License-Identifier: MIT
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# yaml-language-server: $schema=schema.json
machines:
  Qualcomm Technologies, Inc. Maili MTP:
    DSP_LIBRARY_PATH: maili/Qualcomm/Maili-MTP/dsp
YAML_EOF
}
