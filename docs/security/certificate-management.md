# Basic certificate management

Have you ever had to create custom java trust store or been greeted by an error message like `x509: certificate signed by unknown authority`? 
Then this is section is for you.


## Background

Many times enterprises may choose to have an internal PKI and Certificate Authority not trusted by anyone outside the organization.
The drawback of this is that the CA's certificate needs to be distributed on all devices that need to trust the corporate CA.

In the past this has meant that developers have been maintaining custom trust stores for their application runtime. Most commonly seen with Java.

As most runtimes now use the operating systems trust store by default, adding the CA trust to the system trust instead removes the need for the application developer to bring along their own trust store and maintaining it separately when this instead can be part of the corporate Standard Operating Environment (SOE).

## Recommended practice

As these certificates usually does not change very frequently the recommended practice on how to distribute these certificates is by packaging them up as an RPM and install them as part of the SOE.

## References

Additional details about the RHEL system trust store and how to add additional certificates to it is available in the
[product documentation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/securing_networks/using-shared-system-certificates_securing-networks).
