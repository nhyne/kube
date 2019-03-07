generate_pks:
	openssl pkcs12 -inkey privkey.pem -in fullchain.pem -export -out jenkins.pkcs12
	keytool -importkeystore -srckeystore jenkins.pkcs12 -srcstoretype pkcs12 -destkeystore jenkins.jks
