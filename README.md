# next steps 

Trying to make this clearer <br>
Would like to add for my webserver - ngninx and certificate (branch add-certs)
   - tracker-db.com 
      - https certificate on cloudflare
      - mx or email dmarc or something or cloudflar
   - certificate questions 
      - what is the best place for the https certificate authority?
      - is zoho.com the best place for the email certificate? 
   - terraform 
      - having this in terraform and coding is the goal
      - after apply https://tracker-db.com will show "test page or something"
      - the email server will be configured for tracker-db.com and I will get ej@tracker-db.com from zoho or another place that you recommend

We can examine; nextresearch.io is already configured with cloudflare.
   - the records are already there but want the concept in terraform
   - tracker-db and other domains are in "cloudflare" in my vault 
   - let me know if we are ok here?
https://developers.cloudflare.com/dns/manage-dns-records/reference/dns-record-types/

https://github.com/ejbest/terraform-uncommon/tree/add-certs
cloudflare.com 
Login                    domain
erich.ej.best@gmail.com  nextresearch.io
ejbest@gmail.com         tracker-db.com 


2. for each of my domains - see list below - would like to account for tracker db
3. would like to setup the email TX and how "email" will be handled
4. considering zoho (already have) or hubspot (perhaps or some other cheap or free) send email solution
5. want to have complete code / terraform solution for email sending and DMARC / SPF / TXT
6. Have a cloudflare dns module and repo


 <br>
Here is the DNS repo that I have 
- Everything in DNS is in Cloudflare
- Each is in a seperate account for free usage of Cloudflare 
- Each has a current working token my vault.waterskiingguy.com


| Sites                   | Status          |  Login                  |
| :---------------------- |:---------------:| -----------------------:|
| 1. nextresearch.io      | web email       | erich.ej.best@gmail.com |
| 2. tracker-db.com       | not active      |        ejbest@gmail.com |
| 3. advocatediablo.com   | web green       |           ej.best@pm.me |
| 4. auto-deploy.net      | web blue        |  ej.best@protonmail.com | 
| 5. waterskiingguy.com   | web anchor      |             ejb@gmx.com |


| Repo                                                               | Contains            |
| :----------------------------------------------------------------- |:--------------------|
| 1. https://gitlab.com/advocatediablo/dns-cloudflare-update         | DNS settings        |
| 2. https://github.com/ejbest/terraform-uncommon                    | Terraform Test Repo |
| 3. https://github.com/ejbest/cloudflare-dns-terraform-child-module | Check what for      |
 
 
Note: repo prevously was "cloudflare-dns-terraform" and is now "cloudflare-dns-terraform-child-module"
Anystatus?23

WHAT IS NEXT for my discussion here 
1. Need to get email setups for nextresearch.io in code / certifact
   - this is first and formost
   - must be done before below 
   - must be a task done by NYC time 5pm Saturday November 30 
   - Fare Miilestone?  for this item?   for the rest?
2. Will be done using the repo above
3. How should this be improved ?
4. How can this be better orgainzied?
5. would like to move the terraform / domain details to folder "domains" 
6. would like my tools/scripts for drift to be moveed to "tools"
7. would like any thoughts you have 