# extending the `microsoft/aspnet` image.
FROM microsoft/aspnet

# Next, this Dockerfile creates a directory for your application
RUN mkdir C:\TPGISSSO

# configure the new site in IIS.
RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "ASPNET" -PhysicalPath C:\TPGISSSO -BindingInformation "*:8000:"

# This instruction tells the container to listen on port 8000. 
EXPOSE 8888

# The final instruction copies the site you published earlier into the container.
ADD ./TPGISSSO /TPGISSSO