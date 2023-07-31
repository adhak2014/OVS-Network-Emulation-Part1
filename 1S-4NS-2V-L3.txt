echo "\n"
echo "*********************************************"
echo "Configure the host as a temporary forwarder"
sysctl -w net.ipv4.ip_forward=1
echo "*********************************************"
echo "\n"
echo "Delete switch s1 if it exists"
ovs-vsctl --if-exists del-br s1
echo "\n"
echo "Create a new switch s1"
ovs-vsctl add-br s1
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
echo "Create virtual Ethernet cable h2-eth0 <---------------> s1-eth2"
ip link add h2-eth0 type veth peer name s1-eth2
echo "\n"
echo "Create virtual Ethernet cable h3-eth0 <---------------> s1-eth3"
ip link add h3-eth0 type veth peer name s1-eth3
echo "\n"
echo "Create virtual Ethernet cable h4-eth0 <---------------> s1-eth4"
ip link add h4-eth0 type veth peer name s1-eth4
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
echo "Configure default gateway IP address 192.168.1.10 in h1 namespace"
ip netns exec h1 ip route add default via 192.168.1.10
echo "\n"
echo "Bring virtual interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Assign IP address 192.168.1.2/24 to virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.2/24 dev h2-eth0
echo "\n"
echo "Configure default gateway IP address 192.168.1.10 in h2 namespace"
ip netns exec h2 ip route add default via 192.168.1.10
echo "\n"
echo "Bring virtual interface h3-eth0 up"
ip netns exec h3 ip link set dev h3-eth0 up
echo "\n"
echo "Assign IP address 192.168.2.1/24 to virtual interface h3-eth0"
ip netns exec h3 ip address add 192.168.2.1/24 dev h3-eth0
echo "\n"
echo "Configure default gateway IP address 192.168.2.10 in h3 namespace"
ip netns exec h3 ip route add default via 192.168.2.10
echo "\n"
echo "Bring virtual interface h4-eth0 up"
ip netns exec h4 ip link set dev h4-eth0 up
echo "\n"
echo "Assign IP address 192.168.2.2/24 to virtual interface h4-eth0"
ip netns exec h4 ip address add 192.168.2.2/24 dev h4-eth0
echo "\n"
echo "Configure default gateway IP address 192.168.2.10 in h4 namespace"
ip netns exec h4 ip route add default via 192.168.2.10
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
echo "Configure virtual port s1-eth2 in VLAN 10"
ovs-vsctl set port s1-eth2 tag=10
echo "\n"
echo "Add virtual port s1-eth3 to switch s1"
ovs-vsctl add-port s1 s1-eth3
echo "\n"
echo "Bring virtual port s1-eth3 up"
ip link set s1-eth3 up
echo "\n"
echo "Configure virtual port s1-eth3 in VLAN 20"
ovs-vsctl set port s1-eth3 tag=20
echo "\n"
echo "Add virtual port s1-eth4 to switch s1"
ovs-vsctl add-port s1 s1-eth4
echo "\n"
echo "Bring virtual port s1-eth4 up"
ip link set s1-eth4 up
echo "\n"
echo "Configure virtual port s1-eth4 in VLAN 20"
ovs-vsctl set port s1-eth4 tag=20
echo "\n"
echo "Configure switched virtual interface VLAN10 in switch s1"
ovs-vsctl add-port s1 vlan10 tag=10 -- set interface vlan10 type=internal
echo "\n"
echo "Assign IP address 192.168.1.10/24 to switched virtual interface VLAN10 in switch s1"
ip addr add 192.168.1.10/24 dev vlan10
echo "\n"
echo "Bring switched virtual interface VLAN10 up"
ip link set vlan10 up
echo "\n"
echo "Configure switched virtual interface VLAN20 in switch s1"
ovs-vsctl add-port s1 vlan20 tag=20 -- set interface vlan20 type=internal
echo "\n"
echo "Assign IP address 192.168.2.10/24 to switched virtual interface VLAN20 in switch s1"
ip addr add 192.168.2.10/24 dev vlan20
echo "\n"
echo "Bring switched virtual interface VLAN20 up"
ip link set vlan20 up
echo "\n"
echo "Display switch s1 database"
ovs-vsctl show
echo "\n"
echo "Display switch s1 virtual ports"
ovs-vsctl list-ports s1
echo "\n"
echo "Check IPv4 reachability between h1 namespace and h2 namespace"
echo "In h1 namespace, ping 192.168.1.2"
ip netns exec h1 ping -c1 -w1 192.168.1.2
echo "\n"
echo "Check IPv4 reachability between h1 namespace and h3 namespace"
echo "In h1 namespace, ping 192.168.2.1"
ip netns exec h1 ping -c1 -w1 192.168.2.1
echo "\n"
echo "Check IPv4 reachability between h1 namespace and h4 namespace"
echo "In h1 namespace, ping 192.168.2.2"
ip netns exec h1 ping -c1 -w1 192.168.2.2
echo "\n"
echo "Check IPv4 reachability between h2 namespace and h3 namespace"
echo "In h2 namespace, ping 192.168.2.1"
ip netns exec h2 ping -c1 -w1 192.168.2.1
echo "\n"
echo "Check IPv4 reachability between h2 namespace and h4 namespace"
echo "In h2 namespace, ping 192.168.2.2"
ip netns exec h2 ping -c1 -w1 192.168.2.2
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
echo "Bring switch s1 interface s1-eth2 down"
ip link set s1-eth2 down
echo "\n"
echo "Remove virtual port s1-eth2 from switch s1"
ovs-vsctl del-port s1 s1-eth2
echo "\n"
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo "\n"
echo "Bring switch s1 interface s1-eth3 down"
ip link set s1-eth3 down
echo "\n"
echo "Remove virtual port s1-eth3 from switch s1"
ovs-vsctl del-port s1 s1-eth3
echo "\n"
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo "\n"
echo "Bring switch s1 interface s1-eth4 down"
ip link set s1-eth4 down
echo "\n"
echo "Remove virtual port s1-eth4 from switch s1"
ovs-vsctl del-port s1 s1-eth4
echo "\n"
echo "Bring switched virtual interface VLAN10 in switch s1 down"
ip link set vlan10 down
echo "\n"
echo "Delete switched virtual interface VLAN10 in switch s1"
ovs-vsctl del-port s1 vlan10
echo "\n"
echo "Bring switched virtual interface VLAN20 in switch s1 down"
ip link set vlan20 down
echo "\n"
echo "Delete switched virtual interface VLAN20 in switch s1"
ovs-vsctl del-port s1 vlan20
echo "\n"
echo "Delete switch s1"
ovs-vsctl del-br s1
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

