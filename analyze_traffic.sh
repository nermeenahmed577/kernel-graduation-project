#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file
pcap_file=/home/ubuntu/Documents/Linux_Projects/Bash+Network/protocols.pcap

# Function to extract information from the pcap file
analyze_traffic() {
    # Use tshark or similar commands for packet analysis.
    total_packets=$(tshark -r "$pcap_file" | wc -l)
    http_packets=$(tshark -r "$pcap_file" -Y "http" | wc -l)
    https_packets=$(tshark -r "$pcap_file" -Y "tls" | wc -l)

    source_ips=$(tshark -r "$pcap_file" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5)
    dest_ips=$(tshark -r "$pcap_file" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5)

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    echo "1. Total Packets: $total_packets"
    echo "2. Protocols:"
    echo "   - HTTP: $http_packets packets"
    echo "   - HTTPS/TLS: $https_packets packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
  while read count ip; do
    echo "  - $ip: $count packets"
  done <<< "$source_ips"
  echo ""
  echo "4. Top 5 Destination IP Addresses:"
  while read count ip; do
    echo "  - $ip: $count packets"
  done <<< "$dest_ips"
  echo ""
  echo "----- End of Report -----"
}

# Run the analysis function
analyze_traffic