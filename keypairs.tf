resource "aws_key_pair" "keypair" {
    key_name = "${var.prefix}-keypair"
    public_key = file("keys/<PUBLIC-KEY-FILENAME-HERE>.pub")
}
