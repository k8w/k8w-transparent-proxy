FROM alpine:latest

RUN apk add iptables

ENV LISTEN_PORT 8080

# 配置iptables
RUN iptables -t nat -I PREROUTING \
    -p tcp --dport ${LISTEN_PORT} \
    -j DNAT --to-destination ${TO_IP}:${TO_PORT}
RUN iptables -t nat -I POSTROUTING --destination ${TO_IP}/32 -j MASQUERADE

# 开启ipv4_forward
RUN echo 1 > /proc/sys/net/ipv4/ip_forward
RUN sysctl -p

CMD sh