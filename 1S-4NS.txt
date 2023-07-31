echo "\n"
echo "Display the current version of openvswitch"
ovs-vsctl -V
echo "\n"
echo "Delete switch s1 if it exists"
ovs-vsctl --if-exists del-br s1
echo "\n"
echo "Display interfaces in root namespace"
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
echo "Create h4 namespace"
ip netns add h4
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
echo "Display h4 namespace ip interfaces"
ip netns exec h4 ip link
echo "\n"
echo "Create switch s1"
ovs-vsctl add-br s1
echo "\n"
echo "Display a list of configured switches"
ovs-vsctl list-br
echo "\n"
echo "Display a brief overview of switch database configuration"
ovs-vsctl show
echo "\n"
echo "Display interfaces in root namespace"
ip link
echo "\n"
echo "Create a virtual Ethernet cable h1-eth0 <---------------> s1-eth1"
ip link add h1-eth0 type veth peer name s1-eth1
echo "\n"
echo "Create a virtual Ethernet cable h2-eth0 <---------------> s1-eth2"
ip link add h2-eth0 type veth peer name s1-eth2
echo "\n"
echo "Create a virtual Ethernet cable h3-eth0 <---------------> s1-eth3"
ip link add h3-eth0 type veth peer name s1-eth3
echo "\n"
echo "Create a virtual Ethernet cable h4-eth0 <---------------> s1-eth4"
ip link add h4-eth0 type veth peer name s1-eth4
echo "\n"
echo "Display interfaces in root namespace"
ip link
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
echo "Display interfaces in root namespace"
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
echo "Display h4 namespace ip interfaces"
ip netns exec h4 ip link
echo "\n"
echo "Add virtual port s1-eth1 to switch s1"
ovs-vsctl add-port s1 s1-eth1
echo "\n"
echo "Add virtual port s1-eth2 to switch s1"
ovs-vsctl add-port s1 s1-eth2
echo "\n"
echo "Add virtual port s1-eth3 to switch s1"
ovs-vsctl add-port s1 s1-eth3
echo "\n"
echo "Add virtual port s1-eth4 to switch s1"
ovs-vsctl add-port s1 s1-eth4
echo "\n"
echo "Bring switch s1 port s1-eth1 up"
ip link set s1-eth1 up
echo "\n"
echo "Bring switch s1 port s1-eth2 up"
ip link set s1-eth2 up
echo "\n"
echo "Bring switch s1 port s1-eth3 up"
ip link set s1-eth3 up
echo "\n"
echo "Bring switch s1 port s1-eth4 up"
ip link set s1-eth4 up
echo "\n"
echo "Display a list of switch s1 interfaces"
ovs-vsctl list-ports s1
echo "\n"
echo "Display interfaces in root namespace"
ip link
echo "\n"
echo "Bring h1 namespace virtual interface h1-eth0 up"
ip netns exec h1 ip link set dev h1-eth0 up
echo "\n"
echo "Bring h1 namespace virtual interface lo0 up"
ip netns exec h1 ip link set dev lo up
echo "\n"
echo "Assign IP address 192.168.1.1/24 to h1 namespace virtual interface h1-eth0"
ip netns exec h1 ip address add 192.168.1.1/24 dev h1-eth0
echo "\n"
echo "Bring h2 namespace virtual interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Bring h2 namespace virtual interface lo0 up"
ip netns exec h2 ip link set dev lo up
echo "\n"
echo "Assign IP address 192.168.1.2/24 to h2 namespace virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.2/24 dev h2-eth0
echo "\n"
echo "Bring h3 namespace virtual interface h3-eth0 up"
ip netns exec h3 ip link set dev h3-eth0 up
echo "\n"
echo "Bring h3 namespace virtual interface lo0 up"
ip netns exec h3 ip link set dev lo up
echo "\n"
echo "Assign IP address 192.168.1.3/24 to h3 namespace virtual interface h3-eth0"
ip netns exec h3 ip address add 192.168.1.3/24 dev h3-eth0
echo "\n"
echo "Bring h4 namespace virtual interface h4-eth0 up"
ip netns exec h4 ip link set dev h4-eth0 up
echo "\n"
echo "Bring h4 namespace virtual interface lo0 up"
ip netns exec h4 ip link set dev lo up
echo "\n"
echo "Assign IP address 192.168.1.4/24 to h4 namespace virtual interface h4-eth0"
ip netns exec h4 ip address add 192.168.1.4/24 dev h4-eth0
echo "\n"
echo "Display h1 namespace ip interfaces"
ip netns exec h1 ip address
echo "\n"
echo "Display h2 namespace ip interfaces"
ip netns exec h2 ip address
echo "\n"
echo "Display h3 namespace ip interfaces"
ip netns exec h3 ip address
echo "\n"
echo "Display h4 namespace ip interfaces"
ip netns exec h4 ip address
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
echo "Display h4 namespace routing table"
ip netns exec h4 ip route
echo "\n"
echo "From inside the bash shell in h1 namespace, you can ping the other namespaces"
echo "192.168.1.2/24, 192.168.1.3/24, and 192.168.1.4/24"
ip netns exec h1 bash
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

