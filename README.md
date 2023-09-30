# Port-Forward-qBittorrent-With-Proton-VPN
A script that continually requests an open port from Proton VPN, then keeps qBittorrent updated as the port changes.

## Prerequisites
- `curl`
- `natpmpc`
- Preconfigured Wireguard or OpenVPN instance.
- Preconfigured qbittorrent-nox or qBittorrent with WebUI enabled instance.

## Instructions
**portForwarding.sh** <br>
- Replace `[OpenVPN or Wireguard Config]`.service with the name of the systemd service you use to start your VPN. This might be `openvpn@ch.protonvpn.net.udp`.service for OpenVPN or `wg-quick@wg0`.service for Wireguard.
- If you have changed the port from which the qBittorrent WebUI is accessed from  make sure to adjust it in both `localhost` links on the cookie line. The default is `8080`. Also update the password field if necessary (strongly recommended to do so).
- Place the script in `/etc/openvpn/` or `/etc/wireguard` or a different path of your choice. <p>

**portforwarding-protonvpn.service** <br>
- Replace `[OpenVPN or Wireguard Config]` the same way as in `portForwarding.sh`.
- Change `[openvpn|wiregaurd]` in the `ExecStart` line to reflect your VPN choice or replace the whole path with the location of `portForwarding.sh`.
- Place file in `/etc/systemd/system/`.
- Lastly, run the commands below to enable the script to run at boot:
``` 
sudo systemctl enable portforwarding-protonvpn.service
sudo systemctl start portforwarding-protonvpn.service
```

Done! That should be all you need to get port forwarding working.
