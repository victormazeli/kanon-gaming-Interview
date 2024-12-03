resource "aws_route53_zone" "example_com" {
  name = "example.com."  # Replace with your domain iamcloudevops.xyz
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.example_com.id
  name    = "api.example.com"  # Replace with your subdomain
  type    = "CNAME"  # Use "A" if you are pointing to an IP address

  ttl     = 60
  records = [aws_lb.traefik.dns_name]  # Replace with your LoadBalancer DNS name
}

resource "aws_route53_record" "grafana" {
  zone_id = aws_route53_zone.example_com.id
  name    = "grafana.example.com"  # Replace with your subdomain
  type    = "CNAME"

  ttl     = 60
  records = [aws_lb.traefik.dns_name]  # Replace with your LoadBalancer DNS name
}

resource "aws_route53_record" "prometheus" {
  zone_id = aws_route53_zone.example_com.id
  name    = "prometheus.example.com"  # Replace with your subdomain
  type    = "CNAME"

  ttl     = 60
  records = [aws_lb.traefik.dns_name]  # Replace with your LoadBalancer DNS name
}