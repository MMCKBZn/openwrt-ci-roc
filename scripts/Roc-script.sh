# 修改默认IP & 固件名称 & 编译署名和时间
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/hostname='.*'/hostname='Roc'/g" package/base-files/files/bin/config_generate

FILE="feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

cat > /tmp/firmware_replace.txt << EOF
            _('Firmware Version'),
            E('span', {}, [
                (L.isObject(boardinfo.release) ? boardinfo.release.description + ' / ' : '') + (luciversion || '') + ' / ',
                E('a', { href: 'https://github.com/laipeng668/openwrt-ci-roc/releases', target: '_blank', rel: 'noopener noreferrer' }, [ '原作者 by Roc' ]),
                E('span', {}, [ ' & ' ]),
                E('a', { href: 'https://github.com/MMCKBZn/openwrt-ci-roc/releases/tag/JDCloud', target: '_blank', rel: 'noopener noreferrer' }, [ '修改者 by MMCKB ${TIMESTAMP}' ])
            ]),
EOF

sed -i "/_('Firmware Version'),\s*(L\.isObject(boardinfo\.release)/{
    r /tmp/firmware_replace.txt
    d
}" "$FILE"

rm -f /tmp/firmware_replace.txt
# -------------------------------------------------------------
