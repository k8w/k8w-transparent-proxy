FROM alpine:latest

RUN apk add iptables

ENV LISTEN_PORT 8080

# 配置iptables
# 开启ipv4_forward
CMD iptables -t nat -I PREROUTING \
    -p tcp --dport ${LISTEN_PORT} \
    -j DNAT --to-destination ${TO_IP}:${TO_PORT} && \
    iptables -t nat -I POSTROUTING --destination ${TO_IP}/32 -j MASQUERADE && \
    echo 1 > /proc/sys/net/ipv4/ip_forward && \
    sysctl -p && \
    sh