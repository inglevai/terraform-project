# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instances" "webserver" {
    count = "${length(var.subnets_cidr)}"
    ami = "${var.weberver_ami}"
    instance_type = "${var.instance_type}"
    security_groups = "${var.aws_security_groups.webserver.id}"
    subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
    user_data = "${file(install_httpd.sh)}"
    tags = {
        Name     = "${element(var.instance_tags,count.index)}"
        location = "mumbai"
    }  
}
