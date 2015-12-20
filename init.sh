#!/bin/bash

echo "Please enter your quay.io credentials."
read -p "Username: " username 
read -s -p "Password: " password 
read -p "Email: " email

QUAY_USERNAME=$username QUAY_PASSWORD=$password QUAY_EMAIL=$email vagrant up
