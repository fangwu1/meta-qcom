# Use codelinaro hawi-maili branch for Maili MTP (SM8950)
# until qcom-next includes Maili support.
SRC_URI:maili-mtp = " \
    git://git.codelinaro.org/clo/linux-kernel/kernel-qcom.git;branch=hawi-maili;protocol=https \
    file://configs/bsp-additions.cfg \
"

SRCREV:maili-mtp = "21893dadf2a473fb3286519fc02e2743265be809"

# hawi-maili branch does not have prune.config or qcom.config
KBUILD_CONFIG_EXTRA:remove:maili-mtp = "${S}/arch/arm64/configs/prune.config"
KBUILD_CONFIG_EXTRA:remove:maili-mtp = "${S}/arch/arm64/configs/qcom.config"
