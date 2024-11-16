#!/bin/bash

# Define variables
API_URL="https://api64.ipify.org/?format=json"
IPV6_FILE="ipv6.txt"
CLOUDFLARE_API="https://api.cloudflare.com/client/v4"
CLOUDFLARE_TOKEN="xxx"
ZONE_ID="xxx"        # Replace with your Cloudflare Zone ID
RECORD_ID="xxx"    # Replace with your DNS Record ID for the AAAA record

# Step 1: Fetch the current IPv6 address
CURRENT_IPV6=$(curl -s $API_URL | jq -r '.ip')

# Step 2: Read the stored IPv6 address from file
if [ -f "$IPV6_FILE" ]; then
    STORED_IPV6=$(cat "$IPV6_FILE")
else
    STORED_IPV6=""
fi

# Step 3: Compare and update if the IP has changed
if [ "$CURRENT_IPV6" != "$STORED_IPV6" ]; then
    echo "New IPv6 detected. Updating Cloudflare DNS record."

    # Step 4: Update Cloudflare AAAA record with the new IP
    RESPONSE=$(curl -s -X PATCH "$CLOUDFLARE_API/zones/$ZONE_ID/dns_records/$RECORD_ID" \
      -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{\"content\":\"$CURRENT_IPV6\"}")

    # Check if the update was successful
    if echo "$RESPONSE" | jq -e '.success' >/dev/null; then
        echo "Cloudflare AAAA record updated successfully."
        echo "$CURRENT_IPV6" > "$IPV6_FILE"  # Update the IP in the file
    else
        echo "Failed to update Cloudflare DNS record."
        echo "Response: $RESPONSE"
    fi
else
    echo "IPv6 address has not changed."
fi