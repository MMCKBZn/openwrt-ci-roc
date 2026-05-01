# 修改默认IP & 固件名称 & 编译署名和时间
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='.*'/hostname='Roc'/g" package/base-files/files/bin/config_generate

FILE="feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

perl -i -pe "
if (/_('Firmware Version'),/) {
    s|_('Firmware Version'),\s*\(L\.isObject\(boardinfo\.release\)\s*\?\s*boardinfo\.release\.description\s*\+\s*'\s*\/\s*'\s*:\s*''\)\s*\+\s*\(\s*luciversion\s*\|\|\s*''\s*\)|
        _('Firmware Version'),
        E('span', {}, [
            (L.isObject(boardinfo.release)
                ? boardinfo.release.description + ' / '
                : '') + (luciversion || '') + ' / ',
            E('a', {
                href: 'https://github.com/laipeng668/openwrt-ci-roc/releases',
                target: '_blank',
                rel: 'noopener noreferrer'
            }, [ '原作者 by Roc' ]),
            E('span', {}, [ ' & ' ]),
            E('a', {
                href: 'https://github.com/MMCKBZn/openwrt-ci-roc/releases/tag/JDCloud',
                target: '_blank',
                rel: 'noopener noreferrer'
            }, [ '修改者 by MMCKB ${TIMESTAMP}' ])
        ]),|
}" "$FILE"
# ----------------------------------------------------------------------
