echo "\n"
echo "ovs-appctl list-commands"
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
echo "Delete switch s3 if it exists"
ovs-vsctl --if-exists del-br s3
echo "\n"
echo "Delete switch s4 if it exists"
ovs-vsctl --if-exists del-br s4
echo "\n"
echo "Display root namespace interfaces"
ip link
echo "\n"
echo "Create switch s1"
ovs-vsctl add-br s1
echo "\n"
echo "Create switch s2"
ovs-vsctl add-br s2
echo "\n"
echo "Create switch s3"
ovs-vsctl add-br s3
echo "\n"
echo "Create switch s4"
ovs-vsctl add-br s4
echo "\n"
echo "Display a list of configured switches"
ovs-vsctl list-br
echo "\n"
echo "Create virtual Ethernel cable s1-eth1 <---------------> s2-eth0"
ip link add s1-eth1 type veth peer name s2-eth0
echo "\n"
echo "Create virtual Ethernel cable s2-eth1 <---------------> s3-eth0"
ip link add s2-eth1 type veth peer name s3-eth0
echo "\n"
echo "Create virtual Ethernel cable s3-eth1 <---------------> s4-eth0"
ip link add s3-eth1 type veth peer name s4-eth0
echo "\n"
echo "Create virtual Ethernel cable s4-eth1 <---------------> s1-eth0"
ip link add s4-eth1 type veth peer name s1-eth0
echo "\n"
echo "Create virtual port s1-eth0 in switch s1"
ovs-vsctl add-port s1 s1-eth0
echo "\n"
echo "Create virtual port s1-eth1 in switch s1"
ovs-vsctl add-port s1 s1-eth1
echo "\n"
echo "Create virtual port s2-eth0 in switch s2"
ovs-vsctl add-port s2 s2-eth0
echo "\n"
echo "Create virtual port s2-eth1 in switch s2"
ovs-vsctl add-port s2 s2-eth1
echo "\n"
echo "Create virtual port s3-eth0 in switch s3"
ovs-vsctl add-port s3 s3-eth0
echo "\n"
echo "Create virtual port s3-eth1 in switch s3"
ovs-vsctl add-port s3 s3-eth1
echo "\n"
echo "Create virtual port s4-eth0 in switch s4"
ovs-vsctl add-port s4 s4-eth0
echo "\n"
echo "Create virtual port s4-eth1 in switch s4"
ovs-vsctl add-port s4 s4-eth1
echo "\n"
echo "Bring switch s1 interface s1-eth0 up"
ip link set s1-eth0 up
echo "\n"
echo "Bring switch s1 interface s1-eth1 up"
ip link set s1-eth1 up
echo "\n"
echo "Bring switch s2 interface s2-eth0 up"
ip link set s2-eth0 up
echo "\n"
echo "Bring switch s2 interface s2-eth1 up"
ip link set s2-eth1 up
echo "\n"
echo "Bring switch s3 interface s3-eth0 up"
ip link set s3-eth0 up
echo "\n"
echo "Bring switch s3 interface s3-eth1 up"
ip link set s3-eth1 up
echo "\n"
echo "Bring switch s4 interface s4-eth0 up"
ip link set s4-eth0 up
echo "\n"
echo "Bring switch s4 interface s4-eth1 up"
ip link set s4-eth1 up
echo "\n"
echo "Display a brief overview of switch database configuration"
ovs-vsctl show
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
echo "Display again all namespaces"
ls /var/run/netns
echo "\n"
echo "Create virtual Ethernel cable h1-eth0 <---------------> s1-eth2"
ip link add h1-eth0 type veth peer name s1-eth2
echo "\n"
echo "Create virtual Ethernel cable h2-eth0 <---------------> s2-eth2"
ip link add h2-eth0 type veth peer name s2-eth2
echo "\n"
echo "Create virtual Ethernel cable h3-eth0 <---------------> s3-eth2"
ip link add h3-eth0 type veth peer name s3-eth2
echo "\n"
echo "Create virtual Ethernel cable h4-eth0 <---------------> s4-eth2"
ip link add h4-eth0 type veth peer name s4-eth2
echo "\n"
echo "Create virtual port s1-eth2 in switch s1"
ovs-vsctl add-port s1 s1-eth2
echo "\n"
echo "Bring switch s1 interface s1-eth2 up"
ip link set s1-eth2 up
echo "\n"
echo "Create virtual port s2-eth2 in switch s2"
ovs-vsctl add-port s2 s2-eth2
echo "\n"
echo "Bring switch s2 interface s2-eth2 up"
ip link set s2-eth2 up
echo "\n"
echo "Create virtual port s3-eth2 in switch s3"
ovs-vsctl add-port s3 s3-eth2
echo "\n"
echo "Bring switch s3 interface s3-eth2 up"
ip link set s3-eth2 up
echo "\n"
echo "Create virtual port s4-eth2 in switch s4"
ovs-vsctl add-port s4 s4-eth2
echo "\n"
echo "Bring switch s4 interface s4-eth2 up"
ip link set s4-eth2 up
echo "\n"
echo "Attach virtual interface h1-eth0 to h1 namespace"
ip link set h1-eth0 netns h1
echo "\n"
echo "Attach virtual interface h2-eth0 to h2 namespace"
ip link set h2-eth0 netns h2
echo "\n"
echo "Attach virtual interface h3-eth0 to h3 namespace"
ip link set h3-eth0 netns h3
echo "\n"
echo "Attach virtual interface h4-eth0 to h4 namespace"
ip link set h4-eth0 netns h4
echo "\n"
echo "Bring h1 namespace interface h1-eth0 up"
ip netns exec h1 ip link set dev h1-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.1/24 to h1 namespace virtual interface h1-eth0"
ip netns exec h1 ip address add 192.168.1.1/24 dev h1-eth0
echo "\n"
echo "Bring interface lo0 up in h1 namespace"
ip netns exec h1 ip link set lo up
echo "\n"
echo "Bring h2 namespace interface h2-eth0 up"
ip netns exec h2 ip link set dev h2-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.2/24 to h2 namespace virtual interface h2-eth0"
ip netns exec h2 ip address add 192.168.1.2/24 dev h2-eth0
echo "\n"
echo "Bring interface lo0 up in h2 namespace"
ip netns exec h2 ip link set lo up
echo "\n"
echo "Bring h3 namespace interface h3-eth0 up"
ip netns exec h3 ip link set dev h3-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.3/24 to h3 namespace virtual interface h3-eth0"
ip netns exec h3 ip address add 192.168.1.3/24 dev h3-eth0
echo "\n"
echo "Bring interface lo0 up in h3 namespace"
ip netns exec h3 ip link set lo up
echo "\n"
echo "Bring h4 namespace interface h4-eth0 up"
ip netns exec h4 ip link set dev h4-eth0 up
echo "\n"
echo "Assign ip address 192.168.1.4/24 to h4 namespace virtual interface h4-eth0"
ip netns exec h4 ip address add 192.168.1.4/24 dev h4-eth0
echo "\n"
echo "Bring interface lo0 up in h4 namespace"
ip netns exec h4 ip link set lo up
echo "\n"
echo "Enable STP on switch s1"
ovs-vsctl set bridge s1 stp_enable=true
echo "\n"
echo "Enable STP on switch s2"
ovs-vsctl set bridge s2 stp_enable=true
echo "\n"
echo "Enable STP on switch s3"
ovs-vsctl set bridge s3 stp_enable=true
echo "\n"
echo "Enable STP on switch s4"
ovs-vsctl set bridge s4 stp_enable=true
echo "\n"
echo "Display STP parameters for switch s1"
ovs-vsctl get bridge s1 stp_enable
echo "\n"
echo "Display STP parameters for switch s2"
ovs-vsctl get bridge s2 stp_enable
echo "\n"
echo "Display STP parameters for switch s3"
ovs-vsctl get bridge s3 stp_enable
echo "\n"
echo "Display STP parameters for switch s4"
ovs-vsctl get bridge s4 stp_enable
echo "\n"


echo "Pause 40 seconds to allow STP convergence"
sleep 40
echo "\n"

echo "Display switches STP status"
ovs-appctl stp/show
echo "\n"
echo "Check IP connectivity from h1 namespace to h2 namespace at 192.168.1.2"
ip netns exec h1 ping -c1 192.168.1.2
echo "\n"
echo "Check IP connectivity from h1 namespace to h3 namespace at 192.168.1.3"
ip netns exec h1 ping -c1 192.168.1.3
echo "\n"
echo "Check IP connectivity from h1 namespace to h4 namespace at 192.168.1.4"
ip netns exec h1 ping -c1 192.168.1.4
echo "\n"
echo "Display a list of configured switches"
ovs-vsctl list-br
echo "\n"
echo "Display a brief overview of switch database configuration"
ovs-vsctl show
echo "\n"
echo "Bring virtual port s1-eth0 from switch s1 down"
ip link set s1-eth0 down
echo "\n"
echo "Bring virtual port s1-eth1 from switch s1 down"
ip link set s1-eth1 down
echo "\n"
echo "Bring virtual port s1-eth2 from switch s1 down"
ip link set s1-eth2 down
echo "\n"
echo "Bring virtual port s2-eth0 from switch s2 down"
ip link set s2-eth0 down
echo "\n"
echo "Bring virtual port s2-eth1 from switch s2 down"
ip link set s2-eth1 down
echo "\n"
echo "Bring virtual port s2-eth2 from switch s2 down"
ip link set s2-eth2 down
echo "\n"
echo "Bring virtual port s3-eth0 from switch s3 down"
ip link set s3-eth0 down
echo "\n"
echo "Bring virtual port s3-eth1 from switch s3 down"
ip link set s3-eth1 down
echo "\n"
echo "Bring virtual port s3-eth2 from switch s3 down"
ip link set s3-eth2 down
echo "\n"
echo "Bring virtual port s4-eth0 from switch s4 down"
ip link set s4-eth0 down
echo "\n"
echo "Bring virtual port s4-eth1 from switch s4 down"
ip link set s4-eth1 down
echo "\n"
echo "Bring virtual port s4-eth2 from switch s4 down"
ip link set s4-eth2 down
echo "\n"

echo "Remove virtual port s1-eth0 from switch s1"
ovs-vsctl del-port s1 s1-eth0
echo "\n"
echo "Remove virtual port s1-eth1 from switch s1"
ovs-vsctl del-port s1 s1-eth1
echo "\n"
echo "Remove virtual port s1-eth2 from switch s1"
ovs-vsctl del-port s1 s1-eth2
echo "\n"
echo "Remove virtual port s2-eth0 from switch s2"
ovs-vsctl del-port s2 s2-eth0
echo "\n"
echo "Remove virtual port s2-eth1 from switch s2"
ovs-vsctl del-port s2 s2-eth1
echo "\n"
echo "Remove virtual port s2-eth2 from switch s2"
ovs-vsctl del-port s2 s2-eth2
echo "\n"
echo "Remove virtual port s3-eth0 from switch s3"
ovs-vsctl del-port s3 s3-eth0
echo "\n"
echo "Remove virtual port s3-eth1 from switch s3"
ovs-vsctl del-port s3 s3-eth1
echo "\n"
echo "Remove virtual port s3-eth2 from switch s3"
ovs-vsctl del-port s3 s3-eth2
echo "\n"
echo "Remove virtual port s4-eth0 from switch s4"
ovs-vsctl del-port s4 s4-eth0
echo "\n"
echo "Remove virtual port s4-eth1 from switch s4"
ovs-vsctl del-port s4 s4-eth1
echo "\n"
echo "Remove virtual port s4-eth2 from switch s4"
ovs-vsctl del-port s4 s4-eth2
echo "\n"
echo "Delete virtual Ethernel cable s1-eth1 <---------------> s2-eth0"
ip link del s1-eth1 type veth peer name s2-eth0
echo "\n"
echo "Delete virtual Ethernel cable s2-eth1 <---------------> s3-eth0"
ip link del s2-eth1 type veth peer name s3-eth0
echo "\n"
echo "Delete virtual Ethernel cable s3-eth1 <---------------> s4-eth0"
ip link del s3-eth1 type veth peer name s4-eth0
echo "\n"
echo "Delete virtual Ethernel cable s4-eth1 <---------------> s1-eth0"
ip link del s4-eth1 type veth peer name s1-eth0
echo "\n"
echo "Bring h1 namespace interface h1-eth0 down"
ip netns exec h1 ip link set dev h1-eth0 down
echo "\n"
echo "Bring h2 namespace interface h2-eth0 down"
ip netns exec h2 ip link set dev h2-eth0 down
echo "\n"
echo "Bring h3 namespace interface h3-eth0 down"
ip netns exec h3 ip link set dev h3-eth0 down
echo "\n"
echo "Bring h4 namespace interface h4-eth0 down"
ip netns exec h4 ip link set dev h4-eth0 down
echo "\n"

echo "Delete switch s1"
ovs-vsctl del-br s1
echo "\n"
echo "Delete switch s2"
ovs-vsctl del-br s2
echo "\n"
echo "Delete switch s3"
ovs-vsctl del-br s3
echo "\n"
echo "Delete switch s4"
ovs-vsctl del-br s4
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

echo "Pause 5 seconds"
sleep 5
echo "\n"

echo "Check ip links"
ip link
echo "\n"
