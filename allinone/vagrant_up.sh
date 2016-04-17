#!/bin/bash

MY_Deault_Gateway_Subnet=`ip r | grep default | cut -d ' ' -f 3|awk -F '[.]' '{printf "%s.%s.%s.\n",$1,$2,$3}'`

MY_Deault_Gateway_Subnet=${MY_Deault_Gateway_Subnet} vagrant up

