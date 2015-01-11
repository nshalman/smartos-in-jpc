#!/bin/bash

imgadm sources -a https://updates.joyent.com
imgadm import b7493690-f019-4612-958b-bab5f844283e
imgadm import 14a960b0-614e-11e4-a095-eb789315ae39
imgadm sources -d https://updates.joyent.com

vmadm create <<"EOF"
{
    "alias": "ubuntu-32",
    "brand": "lx",
    "kernel_version": "3.13.0",
    "max_physical_memory": 2048,
    "image_uuid": "b7493690-f019-4612-958b-bab5f844283e",
    "resolvers": [
        "8.8.8.8",
        "8.8.4.4"
    ],
    "nics": [
        {
            "nic_tag": "switch0",
            "ip": "172.16.0.2",
            "netmask": "255.255.255.0",
            "gateway": "172.16.0.1",
            "primary": "1"
        }
    ]
}
EOF

vmadm create <<"EOF"
{
    "alias": "ubuntu-64",
    "brand": "lx",
    "kernel_version": "3.13.0",
    "max_physical_memory": 2048,
    "image_uuid": "14a960b0-614e-11e4-a095-eb789315ae39",
    "resolvers": [
        "8.8.8.8",
        "8.8.4.4"
    ],
    "nics": [
        {
            "nic_tag": "switch0",
            "ip": "172.16.0.3",
            "netmask": "255.255.255.0",
            "gateway": "172.16.0.1",
            "primary": "1"
        }
    ]
}
EOF
