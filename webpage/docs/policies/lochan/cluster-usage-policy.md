# Lochan: Cluster Usage Policy

To ensure the stability and usability of the platform for all users, there are certain rules and policies to abide by when using Lochan. This is a living document, so changes can be made at any time. If you have any questions regarding the contents of this page, feel free to get in contact with the admins via Ivanti.

---

## User Accounts
Accounts created on Lochan authenticate through the central authentication service of the University of Glasgow and therefore share the same credentials.

### Eligibility
1. Any staff, student and affiliate is entitled to a personal account. Students and affiliate will have to be approved by a supervisor or manager.
2. Every user is only entitled to one account. Use of multiple accounts to avoid quotas will result in suspension of all involved accounts.
3. Users may be added to different permission groups by the admin team, to allow access to restricted resources. This will usually have to be approved by an owner of a resource.

### Security
1. The sharing of accounts, passwords and SSH keys is strictly forbidden and all details must be kept secure.
2. Any SSH keys used must be passphrase protected.
3. If users were to lock their account or need to reset their password, they can do so through the normal University of Glasgow tools and help-channels.
4. Use of another person's account results in suspension of all involved accounts / users

### Suspension and Termination
1. When access to a user's University of Glasgow GUID is revoked, the login to Lochan gets restricted accordingly.
2. After termination of an account, all data in their home will be deleted.
3. Users may contact the admin team to get their account removed from the system.

## HPC Systems
Lochan is a shared resource used by a large number of people. With the help of quotas, defaults and monitoring the admin teams ensures fair usage, though still relying on individuals to practice good cluster etiquette. Users should be aware of the potential impact of their own activities and comply with the guidelines and policies.

### Jobs
1. Jobs must be run using the Slurm queueing system, interactive or batch jobs. Logging into any worker-nodes directly without a running allocation is forbidden.
2. No compute intensive task is to be run on the login node. The login node is to be used for minor text editing, data management, submitting and monitoring jobs. The admin team reserves the right to kill processes, that constrain the login node, without warning.
3. Compilation should be done in a interactive job, to reduce the load on the login-node.
4. Arrays should be used where appropriate when submitting a large number of jobs.
5. Job submissions must specify the resources to the best estimate of the user, as to not waste cluster resources. This ensures the queueing system runs optimally and therefore the user’s jobs are starting as soon as possible. The admin team reserves the right delete poorly scheduled jobs.
6. The admin team reserves the right to delete, kill or hold jobs or processes that have an adverse effect on the whole system’s stability or health.
7. The job submission system has the capability to send automated emails about the progress of jobs. Users should ensure that the number of requested emails is not excessive and refrain from sending emails to any email address outside the University of Glasgow domain.

### Storage
1. Running jobs with high read/write usage should be working on either local or shared scratch spaces.
2. Temporary files stored on scratch should be deleted as soon as possible, best after end of the associated job.
3. Any data left on scratch spaces after the runtime of the job, may be deleted at any time and without notice.
4. Ensure, that all your scripts, datasets and results are saved to another system, as the admin team offers limited data recovery services.
5. All data stored and processed on Lochan must be anonymised.

### Software
1. All users are responsible for their own use of installed software, including ensuring that use is compatible with the license and terms and conditions of the software. Availability of software installed by the admin team does not imply that all uses of the software are permitted.
2. Users should ensure to only install software from trusted developers/vendors through their official channels.
3. Any software that is no longer required should be deleted from the system.
4. If any suspicious software is found in a user / group space, the admin team may approach users for further question. In severe cases, this could lead to account suspension.
5. Users may request access to restricted software or help with own installations by the admin team.
6. The admin team can help with usage of software to the best of their ability, and may refer a user to other services on Campus.​
7. Periodic reviews of software managed by the admin team will be undertaken and in certain circumstances (e.g. sustained lack of use of software; or emerging security risks disproportionate to the value of software) withdrawal/uninstallation will be actioned.
8. If a user is granted access to a domain software space, they are not allowed to use it for data storage. Breaching this can results in account suspension.

## Maintenance
1. To ensure the stability and security of Lochan, maintenance is needed. This might result in access to the cluster or parts of it being restricted for periods of time. These maintenance windows will be announced at least 2 weeks in advance.
2. In the event of an unplanned outage or disruption to MARS, users will be informed via notification channels.
3. Updates affecting service will only be applied during a scheduled maintenance window.
4. Updates affecting running jobs will only be applied on empty nodes.

---

Please note that in addition to the Cluster Usage Policy users must also comply with the general [IT Policy](https://www.gla.ac.uk/myglasgow/it/policy/) of the University of Glasgow.