This is a simple notebook to demonstrate the [bmv2 simple_switch with ra](https://github.com/awolosewicz/bmv2-remote-attestation) target on FABRIC.
The topology is h1(p0)-(p0)s1(p1)-(p0)h2. As h1 is connected to s1p0, it receives the RA ethernet packets.

IPs/MACs are:
- h1p0: 192.187.1.11/00\:00\:00\:00\:00\:11
- s1p0: 192.187.1.1/00\:00\:00\:00\:00\:01
- s1p1: 192.187.2.1/00\:00\:00\:00\:00\:02
- h2p0: 192.187.2.11/00\:00\:00\:00\:00\:12

The included P4 code is a very simple IPv4 router - it just forwards IPv4 packets either exactly using table ipv4_host or by lpm with ipv4_lpm.
The two files [router.p4](router.p4) and [router2.p4](router2.p4) are functionally identical, and router2 exists largely to enable testing with
load_new_config_file and swap_configs control plane commands. The only difference is a demonstration register (for the register commands) is called
regs_r in router and regs2_r in router2. This register is type bit<32> and size 10.

To use:
1. SSH into s1 then run ./run_bmv2_s1.sh to start the switch
2. SSH again into s1 in another terminal and use ./add_rules_s1.sh to add default routing between h1 and h2
3. SSH into h1 twice. In the first, use the included tcpdump command to view traffic on h1p0, then in the other ping h2.
   The tcpdump will show 4 packets - the ICMP Echo request, reply, and two ethernet packets of type 0x8822.
   The ethernet packets contain three 16 byte fields which hold the RA data, as described in the above repository.
4. Use the second s1 terminal earlier to use simple_switch_CLI to modify registers/table entries/programs, and run a ping through
   h1 again to see how the RA data changes. The exact functions which trigger the RA data to rehash are described in the above repository.