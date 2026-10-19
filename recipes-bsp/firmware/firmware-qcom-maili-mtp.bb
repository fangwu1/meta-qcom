# Firmware binaries for SM8950 Maili MTP board hosted on internal Artifactory.
# Once maili firmware is upstreamed to linux-firmware, update SRC_URI accordingly.

DESCRIPTION = "QCOM Firmware for SM8950 Maili MTP board"
LICENSE = "LicenseRef-Firmware-qcom-2"
NO_GENERIC_LICENSE[Firmware-qcom-2] = "LICENSES/LICENSE.qcom-2"
LIC_FILES_CHKSUM = "file://LICENSES/LICENSE.qcom-2;md5=165287851294f2fb8ac8cbc5e24b02b0"

FW_ARTIFACTORY = "artifactory-las.qualcomm.com/artifactory/lint-lv-local/firmware-artifacts"

PV = "20260917"

SRC_URI = "https://${FW_ARTIFACTORY}/linux-firmware-maili-${PV}.tar.xz;name=firmware"
SRC_URI[firmware.sha256sum] = "a57df0e4f228b223a54fc2f1f3c4f880c78803cb120383f2a8d703f7fa074690"

S = "${UNPACKDIR}/linux-firmware-maili-${PV}"

FW_QCOM_NAME = "maili"

require recipes-bsp/firmware/firmware-qcom.inc

INHIBIT_DEFAULT_DEPS = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

SPLIT_FIRMWARE_PACKAGES = "\
    linux-firmware-qcom-${FW_QCOM_NAME}-compute \
    linux-firmware-qcom-${FW_QCOM_NAME}-adreno \
    linux-firmware-qcom-${FW_QCOM_NAME}-vpu \
"

FILES:linux-firmware-qcom-${FW_QCOM_NAME}-adreno:append = " \
    ${FW_QCOM_BASE_PATH}/gen81100_aqe.fw \
    ${FW_QCOM_BASE_PATH}/gen81100_sqe.fw \
    ${FW_QCOM_BASE_PATH}/gen81100_gmu.bin \
"

FILES:linux-firmware-qcom-${FW_QCOM_NAME}-vpu = "${FW_QCOM_BASE_PATH}/vpu/vpu40_p1_s8.mbn"

do_install() {
    install -d ${D}${FW_QCOM_PATH}
    cp -r ${S}/qcom/maili/. ${D}${FW_QCOM_PATH}/
    # Remove audio firmware (adsp*) provided by upstream linux-firmware
    rm -f ${D}${FW_QCOM_PATH}/adsp*

    install -d ${D}${FW_QCOM_BASE_PATH}
    for fw in gen81100_aqe.fw gen81100_sqe.fw gen81100_gmu.bin; do
        install -m 0644 ${S}/qcom/$fw ${D}${FW_QCOM_BASE_PATH}/
    done

    install -d ${D}${FW_QCOM_BASE_PATH}/vpu
    install -m 0644 ${S}/qcom/vpu/vpu40_p1_s8.mbn ${D}${FW_QCOM_BASE_PATH}/vpu/
}
