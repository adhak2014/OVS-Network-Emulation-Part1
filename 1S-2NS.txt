echo "\n"
echo "Display the current version of openvswitch"
ovs-vsctl -V
echo "\n"
echo "Delete switch s1 if it exists"
ovs-vsctl --if-exists del-br s1
echo "\n"
echo "Display root namespace interfaces"
ip link
echo "\n"
echo "Create h1 namespace"
ip netns add h1
echo "\n"
echo "Create h2 namespace"
ip netns add h2
echo "\n"
echo "Display all created namespaces"
ip netns
echo "\n"
echo "Display namespace h1 ip interfaces"
ip netns exec h1 ip link
echo "\n"
echo "Display namespace h2 ip interfaces"
ip netns exec h2 ip link
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
echo "Create virtual Ethernel cable h1-eth0 <---------------> s1-eth1"
ip link add h1-eth0 type veth peer name s1-eth1
echo "\n"
echo "Create virtual Ethernel cable h2-eth0 <---------------> s1-eth2"
ip link add h2-eth0 type veth peer name s1-eth2
echo "\n"
echo "Display root namespace ip interfaces"
ip link
echo "\n"
echo "Assign virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Assign virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Display root namespace ip interfaces"
ip link
echo "\n"
echo "Display h1 namespace ip interfaces"
ip netns exec h1 ip link
echo "\n"
echo "Display h2 namespace ip interfaces"
ip netns exec h2 ip link
echo "\n"
echo "Create virtual port s1-eth1 in switch s1"
ovs-vsctl add-port s1 s1-eth1
echo "\n"
echo "Create virtual port s1-eth2 in switch s1"
ovs-vsctl add-port s1 s1-eth2
echo "\n"
echo "Bring switch s1 interface s1-eth1 up"
ip link set s1-eth1 up
echo "\n"
echo "Bring switch s2 interface s1-eth2 up"
ip link set s1-eth2 up
echo "\n"
echo "Display a list of switch s1 interfaces"
ovs-vsctl list-ports s1
echo "\n"
echo "Display root namespace ip interfaces"
ip link
echo "\n"
echo "Bring h1 namespace interface h1-eth0 up"
ip netns exec h1 ip link set dev h1-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.10/24 to h1 namespace virtual interface h1-eth0"
ip netns exec h1 ip address add 192.168.1.10/24 dev h1-eth0
echo "\n"
echo "Bring interface lo0 up in h1 namespace"
ip netns exec h1 ip link set lo up
echo "\n"
echo "Bring h2 namespace interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.20/24 to h2 namespace virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.20/24 dev h2-eth0
echo "\n"
echo "Bring interface lo0 up in h2 namespace"
ip netns exec h2 ip link set lo up
echo "\n"
echo "Display h1 namespace ip addresses"
ip netns exec h1 ip address
echo "\n"
echo "Display h2 namespace ip addresses"
ip netns exec h2 ip address
echo "\n"
echo "Display h1 namespace routing table"
ip netns exec h1 ip route
echo "\n"
echo "Display h2 namespace routing table"
ip netns exec h2 ip route
echo "\n"
echo "From inside the bash shell in h1 namespace, you can ping h2 namespace (192.168.1.20). To leave the bash shell, type exit"
ip netns exec h1 bash
echo "\n"
echo "From inside the bash shell in h2 namespace, you can ping h1 namespace (192.168.1.10). To leave the bash shell, type exit"
ip netns exec h2 bash
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
echo "Check if any namespace(s) is/are left"
ip netns
echo "\n"

