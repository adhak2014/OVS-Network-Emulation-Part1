echo "\n"
echo "Display the current version of openvswitch"
ovs-vsctl -V
echo "\n"
echo "Delete switch s1 if it exists"
ovs-vsctl --if-exists del-br s1
echo "\n"
echo "Delete switch s2 if it exists"
ovs-vsctl --if-exists del-br s2
echo "\n"
echo "Display ip interfaces in root namespace"
ip link
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
echo "Display all namespaces"
ip netns
echo "\n"
echo "Display h1 namespace ip interfaces"
ip netns exec h1 ip link
echo "\n"
echo "Display h2 namespace ip interfaces"
ip netns exec h2 ip link
echo "\n"
echo "Display h3 namespace ip interfaces"
ip netns exec h3 ip link
echo "\n"
echo "Create switch s1"
ovs-vsctl add-br s1
echo "\n"
echo "Create switch s2"
ovs-vsctl add-br s2
echo "\n"
echo "Display a list of configured switches"
ovs-vsctl list-br
echo "\n"
echo "Display a brief overview of switches database configuration"
ovs-vsctl show
echo "\n"
echo "Display ip interfaces in root namespace"
ip link
echo "\n"
echo "Create virtual Ethernet cable h1-eth0 <---------------> s1-eth1"
ip link add h1-eth0 type veth peer name s1-eth1
echo "\n"
echo "Create virtual Ethernet cable h2-eth0 <---------------> s1-eth2"
ip link add h2-eth0 type veth peer name s1-eth2
echo "\n"
echo "Create virtual Ethernet cable h2-eth1 <---------------> s2-eth1"
ip link add h2-eth1 type veth peer name s2-eth1
echo "\n"
echo "Create virtual Ethernet cable h3-eth0 <---------------> s2-eth2"
ip link add h3-eth0 type veth peer name s2-eth2
echo "\n"
echo "Display ip interfaces in root namespace"
ip link
echo "\n"
echo "Add virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Add virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Add virtual interface h2-eth1 to h2 namespace"
ip link set h2-eth1 netns h2
echo "\n"
echo "Add virtual interface h3-eth0 to h3 namespace"
ip link set h3-eth0 netns h3
echo "\n"
echo "Display ip interfaces in root namespace"
ip link
echo "\n"
echo "Display h1 namespace ip interfaces"
ip netns exec h1 ip link
echo "\n"
echo "Display h2 namespace ip interfaces"
ip netns exec h2 ip link
echo "\n"
echo "Display h3 namespace ip interfaces"
ip netns exec h3 ip link
echo "\n"
echo "Add virtual interface s1-eth1 to switch s1"
ovs-vsctl add-port s1 s1-eth1
echo "\n"
echo "Add virtual interface s1-eth2 to switch s1"
ovs-vsctl add-port s1 s1-eth2
echo "\n"
echo "Add virtual interface s2-eth1 to switch s2"
ovs-vsctl add-port s2 s2-eth1
echo "\n"
echo "Add virtual interface s2-eth2 to switch s2"
ovs-vsctl add-port s2 s2-eth2
echo "\n"
echo "Bring virtual switch interface s1-eth1 up"
ip link set s1-eth1 up
echo "\n"
echo "Bring virtual switch interface s1-eth2 up"
ip link set s1-eth2 up
echo "\n"
echo "Bring virtual switch interface s2-eth1 up"
ip link set s2-eth1 up
echo "\n"
echo "Bring virtual switch interface s2-eth2 up"
ip link set s2-eth2 up
echo "\n"
echo "Display a list of switch s1 interfaces"
ovs-vsctl list-ports s1
echo "\n"
echo "Display a list of switch s2 interfaces"
ovs-vsctl list-ports s2
echo "\n"
echo "Display ip interfaces in root namespace"
ip link
echo "\n"
echo "Bring h1 namespace virtual interface lo up"
ip netns exec h1 ip link set dev lo up
echo "\n"
echo "Bring h1 namespace virtual interface h1-eth0 up"
ip netns exec h1 ip link set dev h1-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.1/24 to virtual interface h1-eth0"
ip netns exec h1 ip address add 192.168.1.1/24 dev h1-eth0
echo "\n"
echo "Bring h2 namespace virtual interface lo up"
ip netns exec h2 ip link set dev lo up
echo "\n"
echo "Bring h2 namespace virtual interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.2/24 to virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.2/24 dev h2-eth0
echo "\n"
echo "Bring h2 namespace virtual interface h2-eth1 up"
ip netns exec h2 ip link set dev h2-eth1 up
echo "\n"
echo "Assign ip address 192.168.2.1/24 to virtual interface h2-eth1"
ip netns exec h2 ip address add 192.168.2.1/24 dev h2-eth1
echo "\n"
echo "Bring h3 namespace virtual interface lo up"
ip netns exec h3 ip link set dev lo up
echo "\n"
echo "Bring h3 namespace virtual interface h3-eth0 up"
ip netns exec h3 ip link set dev h3-eth0 up
echo "\n"
echo "Assign ip address 192.168.2.2/24 to virtual interface h3-eth0"
ip netns exec h3 ip address add 192.168.2.2/24 dev h3-eth0
echo "\n"
echo "Display h1 namespace ip addresses"
ip netns exec h1 ip address
echo "\n"
echo "Display h2 namespace ip addresses"
ip netns exec h2 ip address
echo "\n"
echo "Display h3 namespace ip addresses"
ip netns exec h3 ip address
echo "\n"
echo "Display h1 namespace routing table"
ip netns exec h1 ip route
echo "\n"
echo "Display h2 namespace routing table"
ip netns exec h2 ip route
echo "\n"
echo "Display h3 namespace routing table"
ip netns exec h3 ip route
echo "\n"
echo "From inside the bash shell in h1 namespace, you can ping h2 namespace"
echo "ping 192.168.1.2"
ip netns exec h1 bash
echo "\n"
echo "From inside the bash shell in h3 namespace, you can ping h2 namespace"
echo "ping 192.168.2.1"
ip netns exec h3 bash
echo "\n"
echo "From h2 namespace, ping h1 namespace"
ip netns exec h2 ping -c1 192.168.1.1
echo "\n"
echo "From h2 namespace, ping h3 namespace"
ip netns exec h2 ping -c1 192.168.2.2
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
echo "Bring h2 namespace interface h2-eth1 down"
ip netns exec h2 ip link set dev h2-eth1 down
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
echo "Bring switch s2 interface s2-eth2 down"
ip link set s2-eth2 down
echo "\n"
echo "Remove virtual port s2-eth2 from switch s2"
ovs-vsctl del-port s2 s2-eth2
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
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"
