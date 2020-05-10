# https://www.terraform.io/docs/providers/aws/r/elb.html

# Create a new load balancer
resource "aws_elb" "tf_vai_elb" {
  name               = "tf_vai_elb"
  subnets = "${aws_subnet.public.*.id}"
  security_groups = ["${aws_security_groups.webserver.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["${aws_instance.webserver.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 100
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "TF-Vai-elb"
  }
}

output "elb_dns_name" {
  value = "${aws_elb.tf_vai_elb.dns_name}"
}
