alias Rumbl.Repo
alias Rumbl.Accounts.User

Repo.insert(%User{
name: "José",
username: "josevalim",
password_hash: "$pbkdf2-sha512$160000$ZslaZ4l.6VEIb3AO0bfpNg$dLUG1Tmx0ZVDO2fbJYEB.Hj6rclV73ZrGo2JGuxbYCAS8Zv1ty8XDbudPGj0oULTYz54yG8WJwZEsrQ.FkVeUQ"
})

Repo.insert(%User{
name: "Bruce",
username: "redrapids",
password_hash: "$pbkdf2-sha512$160000$ElkGWZzRQKxpO48irERsLQ$jd7FDOYi.jj3P5VFoDNPyP1DamB1qDIeey4fxzQ/E0Gbuk5i44ntvzJDMw9s0JumrgMS3t5eUFrNzVv1qmLsGA"
})

Repo.insert(%User{
name: "Chris",
username: "mccord",
password_hash: "$pbkdf2-sha512$160000$X8aXTSljOj/g9bqpxwCarQ$E8l0NVUrT3ejPmXXFQtlx55CxCP4wK6bpJc8rpAzzDIKUWPdCofdlcs0DfTY55OuwENsebYGHPMxWEemNMsKFg"
})