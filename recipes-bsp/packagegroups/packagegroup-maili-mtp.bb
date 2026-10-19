SUMMARY = "Packages for the Maili MTP board"

inherit packagegroup

PACKAGES = " \
    ${PN}-firmware \
    ${PN}-hexagon-dsp-binaries \
"

RRECOMMENDS:${PN}-firmware = " \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'opencl opengl vulkan', 'linux-firmware-qcom-maili-adreno', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'linux-firmware-qca-wcn7850', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wifi', 'linux-firmware-ath12k-wcn7850', '', d)} \
    firmware-qcom-maili-mtp \
    linux-firmware-qcom-maili-audio \
    linux-firmware-qcom-maili-compute \
    linux-firmware-qcom-maili-vpu \
"

RRECOMMENDS:${PN}-hexagon-dsp-binaries = " \
    hexagon-dsp-binaries-qcom-maili-mtp-adsp \
    hexagon-dsp-binaries-qcom-maili-mtp-cdsp \
"
