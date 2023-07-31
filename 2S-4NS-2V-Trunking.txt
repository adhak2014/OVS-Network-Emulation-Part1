echo "\n"
echo "Delete switch s1, if it exists"
ovs-vsctl --if-exists del-br s1
echo "\n"
echo "Delete switch s2, if it exists"
ovs-vsctl --if-exists del-br s2
echo "\n"
echo "Create a new switch s1"
ovs-vsctl add-br s1
echo "\n"
echo "Create a new switch s2"
ovs-vsctl add-br s2
echo "\n"
echo "Display all switches"
ovs-vsctl list-br
echo "\n"
echo "Create h1 namespace"
ip netns add h1
echo "\n"
echo "Create h2 namespace"
ip netns add h2
echo "\n"
echo "Create h3 namespace"
ip netns add h3
echo "\n"
echo "Create h4 namespace"
ip netns add h4
echo "\n"
echo "Display all namespaces"
ip netns
echo "\n"
echo "Create virtual Ethernet cable h1-eth0 <---------------> s1-eth1"
ip link add h1-eth0 type veth peer name s1-eth1
echo "\n"
echo "Create virtual Ethernet cable h2-eth0 <---------------> s2-eth1"
ip link add h2-eth0 type veth peer name s2-eth1
echo "\n"
echo "Create virtual Ethernet cable h3-eth0 <---------------> s1-eth2"
ip link add h3-eth0 type veth peer name s1-eth2
echo "\n"
echo "Create virtual Ethernet cable h4-eth0 <---------------> s2-eth2"
ip link add h4-eth0 type veth peer name s2-eth2
echo "\n"
echo "Add virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Add virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Add virtual interface h3-eth0 to h3 namespace"
ip link set h3-eth0 netns h3
echo "\n"
echo "Add virtual interface h4-eth0 to h4 namespace"
ip link set h4-eth0 netns h4
echo "\n"
echo "Bring virtual interface h1-eth0 up"
ip netns exec h1 ip link set dev h1-eth0 up
echo "\n"
echo "Assign IP address 192.168.1.1/24 to virtual interface h1-eth0"
ip netns exec h1 ip address add 192.168.1.1/24 dev h1-eth0
echo "\n"
echo "Bring virtual interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Assign IP address 192.168.1.2/24 to virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.2/24 dev h2-eth0
echo "\n"
echo "Bring virtual interface h3-eth0 up"
ip netns exec h3 ip link set dev h3-eth0 up
echo "\n"
echo "Assign IP address 192.168.2.1/24 to virtual interface h3-eth0"
ip netns exec h3 ip address add 192.168.2.1/24 dev h3-eth0
echo "\n"
echo "Bring virtual interface h4-eth0 up"
ip netns exec h4 ip link set dev h4-eth0 up
echo "\n"
echo "Assign IP address 192.168.2.2/24 to virtual interface h4-eth0"
ip netns exec h4 ip address add 192.168.2.2/24 dev h4-eth0
echo "\n"
echo "Add virtual port s1-eth1 to switch s1"
ovs-vsctl add-port s1 s1-eth1
echo "\n"
echo "Bring virtual port s1-eth1 up"
ip link set s1-eth1 up
echo "\n"
echo "Configure virtual port s1-eth1 in VLAN 10"
ovs-vsctl set port s1-eth1 tag=10
echo "\n"
echo "Add virtual port s1-eth2 to switch s1"
ovs-vsctl add-port s1 s1-eth2
echo "\n"
echo "Bring virtual port s1-eth2 up"
ip link set s1-eth2 up
echo "\n"
echo "Configure virtual port s1-eth2 in VLAN 20"
ovs-vsctl set port s1-eth2 tag=20
echo "\n"
echo "Add virtual port s2-eth1 to switch s2"
ovs-vsctl add-port s2 s2-eth1
echo "\n"
echo "Bring virtual port s2-eth1 up"
ip link set s2-eth1 up
echo "\n"
echo "Configure virtual port s2-eth1 in VLAN 10"
ovs-vsctl set port s2-eth1 tag=10
echo "\n"
echo "Add virtual port s2-eth2 to switch s2"
ovs-vsctl add-port s2 s2-eth2
echo "\n"
echo "Bring virtual port s2-eth2 up"
ip link set s2-eth2 up
echo "\n"
echo "Configure virtual port s2-eth2 in VLAN 20"
ovs-vsctl set port s2-eth2 tag=20
echo "\n"
echo "Create a trunk between switch s1 and switch s2"
echo "\n"
echo "Create virtual Ethernet cable s1-eth3 <---------------> s2-eth3"
ip link add s1-eth3 type veth peer name s2-eth3
echo "\n"
echo "Configure virtual switchport s1-eth3 as a trunk port"
ovs-vsctl add-port s1 s1-eth3
echo "\n"
echo "Bring virtual trunk port s1-eth3 up"
ip link set s1-eth3 up
echo "\n"
echo "Configure switch s1 trunk port s1-eth3 to allow VLANs 10 and 20"
ovs-vsctl set port s1-eth3 trunks=10,20
echo "\n"
echo "Configure virtual switchport s2-eth3 as a trunk port"
ovs-vsctl add-port s2 s2-eth3
echo "\n"
echo "Bring virtual trunk port s2-eth3 up"
ip link set s2-eth3 up
echo "\n"
echo "Configure switch s2 trunk port s2-eth3 to allow VLANs 10 and 20"
ovs-vsctl set port s2-eth3 trunks=10,20
echo "\n"
echo "Display switches s1 and s2 databases"
ovs-vsctl show
echo "\n"
echo "Display switch s1 virtual ports"
ovs-vsctl list-ports s1
echo "\n"
echo "Display switch s2 virtual ports"
ovs-vsctl list-ports s2
echo "\n"
echo "Check IPv4 reachability between h1 namespace and h2 namespace"
echo "In h1 namespace, ping 192.168.1.2"
ip netns exec h1 ping -c2 192.168.1.2
echo "\n"
echo "Check IPv4 reachability between h3 namespace and h4 namespace"
echo "In h3 namespace, ping 192.168.2.2"
ip netns exec h3 ping -c2 192.168.2.2
echo "\n"
echo "Display switch s1 MAC addresses table"
ovs-appctl fdb/show s1
echo "\n"
echo "Display switch s2 MAC addresses table"
ovs-appctl fdb/show s2
echo "\n"
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo "\n"
echo "Bring switch s1 interface s1-eth1 down"
ip link set s1-eth1 down
echo "\n"
echo "Remove virtual port s1-eth1 from switch s1"
ovs-vsctl del-port s1 s1-eth1
echo "\n"
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
echo "\n"
echo "Bring switch s2 interface s2-eth1 down"
ip link set s2-eth1 down
echo "\n"
echo "Remove virtual port s2-eth1 from switch s2"
ovs-vsctl del-port s2 s2-eth1
echo "\n"
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo "\n"
echo "Bring switch s1 interface s1-eth2 down"
ip link set s1-eth2 down
echo "\n"
echo "Remove virtual port s1-eth2 from switch s1"
ovs-vsctl del-port s1 s1-eth2
echo "\n"
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo "\n"
echo "Bring switch s2 interface s2-eth2 down"
ip link set s2-eth2 down
echo "\n"
echo "Remove virtual port s2-eth2 from switch s2"
ovs-vsctl del-port s2 s2-eth2
echo "\n"
echo "Bring switch s1 trunk port s1-eth3 down"
ip link set s1-eth3 down
echo "\n"
echo "Bring switch s2 trunk port s2-eth3 down"
ip link set s2-eth3 down
echo "\n"
echo "Delete virtual Ethernet cable s1-eth3 <---------------> s2-eth3"
ip link delete s1-eth3 type veth peer name s2-eth3
echo "\n"
echo "Delete switch s1"
ovs-vsctl del-br s1
echo "\n"
echo "Delete switch s2"
ovs-vsctl del-br s2
echo "\n"
echo "Display a list of switches, if any"
ovs-vsctl list-br
echo "\n"
echo "Delete h1 namespace"
ip netns delete h1
echo "\n"
echo "Delete h2 namespace"
ip netns delete h2
echo "\n"
echo "Delete h3 namespace"
ip netns delete h3
echo "\n"
echo "Delete h4 namespace"
ip netns delete h4
echo "\n"
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"
echo "Check ip links"
ip link
echo "\n"

