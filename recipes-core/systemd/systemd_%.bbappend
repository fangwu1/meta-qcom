FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/${PN}:"

SRC_URI:append:qcom = " \
    file://99-dma-heap.rules \
    file://systemd-boot-update.service.d/override.conf \
    file://systemd-boot-random-seed.service.d/override.conf \
"

# Create a group dmaheap and add this group to /dev/dma_heap/system through
# dma-heap rules.
GROUPADD_PARAM:udev:append:qcom = "; -r dmaheap"

do_install:append:qcom() {
    install -d ${D}${nonarch_libdir}/udev/rules.d
    install -m 0644 ${UNPACKDIR}/99-dma-heap.rules \
        ${D}${nonarch_libdir}/udev/rules.d/

    install -d ${D}${systemd_system_unitdir}/systemd-boot-update.service.d
    install -m 0644 ${UNPACKDIR}/systemd-boot-update.service.d/override.conf \
        ${D}${systemd_system_unitdir}/systemd-boot-update.service.d/override.conf

    install -d ${D}${systemd_system_unitdir}/systemd-boot-random-seed.service.d
    install -m 0644 ${UNPACKDIR}/systemd-boot-random-seed.service.d/override.conf \
        ${D}${systemd_system_unitdir}/systemd-boot-random-seed.service.d/override.conf
}

FILES:${PN}:append:qcom = " \
    ${systemd_system_unitdir}/systemd-boot-update.service.d/override.conf \
    ${systemd_system_unitdir}/systemd-boot-random-seed.service.d/override.conf \
"

FILES:${PN}-udev-rules:append:qcom = " ${nonarch_libdir}/udev/rules.d/99-dma-heap.rules"
