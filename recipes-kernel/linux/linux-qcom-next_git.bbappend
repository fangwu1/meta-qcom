FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-next:"

SRC_URI += " \
    file://patches/0001-FROMLIST-arm64-dts-qcom-talos-Add-DisplayPort-and-QM.patch \
    file://patches/0002-FROMLIST-arm64-dts-qcom-qcs615-ride-Enable-DisplayPo.patch \
    file://patches/0003-dt-bindings-arm-qcom-talos-evk-Add-QCS615-Talos-EVK-.patch \
    file://patches/0004-arm64-dts-qcom-talos-evk-Add-support-for-QCS615-talo.patch \
"

