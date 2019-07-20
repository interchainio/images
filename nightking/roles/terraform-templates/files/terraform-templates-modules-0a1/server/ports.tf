resource "aws_security_group" "server" {
  name = "${var.role}${var.id}-ports"
  ingress {
    from_port = 26656
    protocol = "tcp"
    to_port = 26656
    cidr_blocks = ["0.0.0.0/0"]
    description = "Tendermint P2P port"
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${var.nightking_ip}/32"]
  }
}
