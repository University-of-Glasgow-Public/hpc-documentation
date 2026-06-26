# User Eligibility and Management

## User Types

There are three user types on MARS. These types are listed and explained here:

### MVLS Staff and Students

This category includes all staff and students belonging to the College of Medical, Veterinary and Life Sciences (MVLS) at the University of Glasgow.

Eligibility

Users of this type are eligible for an account as individuals, with only access to the none account, or as part of a project. They are also eligible to request and be PI of a project on MARS.

### Non-MVLS University of Glasgow Staff and Students

This category includes all staff and students not part of the College of Medical, Veterinary and Life Sciences (MVLS), but belonging to other Colleges, Schools and other units within the University of Glasgow.

Eligibility

These users are eligible for an account if they are part of a MARS approved project. The project has to already be created on the cluster, for the accounts to be created. If the project on MARS finishes, these users will be no longer eligible and their access to the platform will be revoked.

In addition, MARS project requests originating from outside MVLS may be accepted with the proviso of sufficient spare capacity over the lifetime of the proposed project and where such projects do not affect the availability of MARS to MVLS users.

 An external-to-MVLS project should have precisely stated goals, resource requirements and project start and end dates. A brief explanation should be provided for why MARS is the most appropriate destination and usage should be directly related to that project’s goals.

### University of Glasgow Affiliate and Honorary Staff

Affiliates are individuals who are not directly employed by the University of Glasgow in a formal contractual capacity but may undertake roles of temporary nature within the University of Glasgow. Honorary status is awarded in recognition of an individual’s contribution to teaching, research and scholarship in the University. Such posts are non-stipendiary/unpaid. More information on both statuses can be found on the [University of Glasgow website](https://www.gla.ac.uk/myglasgow/it/businesssystems/hms/).

Eligibility

Affiliate and Honorary users are eligible for an account if they are part of a MARS approved project. The project has to already be created on the cluster for the accounts to be created. If the project on MARS finishes, these users are no longer eligible and their access to the platform will be revoked. In addition, the PI of the project the Affiliate or Honorary user is associated with will have to reapprove their access on an annual basis.

---

## User Creation

Everyone with access to Ivanti and a University of Glasgow email may issue a MARS HPC access request. In general third party requests are not permitted and therefore all users should request their own account individually. Bulk requests may be considered on an individual basis, for example to facilitate a teaching project on MARS. MARS HPC requests are processed by the “Shared Research Facilities” team, which contains all MARS admins. Upon receipt an administrator will accept the ticket, verify the user’s eligibility and where eligible, create the user with a tool provided by the host provider Alces.

The tool does the following:

- Creates a UNIX user, using the University of Glasgow GUID as the user identification.
- Create a Slurm user, using the University of Glasgow GUID as the user identification.
- Associates the Slurm user with the none account which is used to request individual jobs, not associated with a project.
- Creates home and scratch directories for the user.
- Sets a quota restriction on the user’s home directory.

Where requested, the user may also be added to a project. A user will only be added to a project if approved by any of the PIs listed in the project documentation. Approval may be provided either via the MARS admin messaging the PI for validation, or the PI approaching the admin team to add a new user.

A user account will always be bound to the University of Glasgow Active Directory account and therefore the password will always correspond to the password set for the Active Directory account. When a user account is disabled in Active Directory, they will also be disabled on MARS.

In the case, where a formerly student user becomes a staff member with a new user account they must request a new MARS account through Ivanti. If the data of the old student account is still available, an admin may move the data over, upon request by the user.

---

## User Account Retirement

User accounts may be retired for any the following reasons:

1. User no longer meets eligibility criteria.
2. User requests retirement of their own account.
3. User is barred from using the system due to policy violation.
4. User is no longer part of the organisation.

In the case of reasons 1 and 2, an informational email is sent out to these users, informing them of the retirement 1 week in advance. Following the notice period the user account is disabled from MARS, using the tool provided by the host provider Alces. After a 3 month grace period, all their personal data is then deleted from the platform. This includes home directories and scratch spaces, all data attributed to a user within projects spaces will stay available. For any permission issues, users can contact the MARS admin team for help.

Here a timeline of this process:

|||
|---|---|
|**Time**|**Action**|
|Now|User is informed via email about the retirement process starting.|
|1 week|User account is disabled through the tools provided by the hoster Alces.|
|3 months|User account is deleted through the tool provided by hoster Alces and all user data is deleted from the system.|

In case of reason 3, the notice period is skipped and the user is instead informed, that their account has been suspended immediately. After a 3 month grace period, all their personal data is then deleted from the platform. This includes home directories and scratch spaces, all data attributed to a user within projects spaces will stay available. For any permission issues, users can contact the MARS admin team for help.

In the case of reason 4, the user will not have access to the data after the account has been disabled on Active Directory. Once the Active Directory account has been deleted, all their personal data will be deleted from the platform. This includes home directories and scratch spaces, all data attributed to a user within projects spaces will stay available. For any permission issues, users can contact the MARS admin team for help.

---

## Glossary

|||
|---|---|
|**Term**|**Definition**|
|MARS|MVLS Advanced Research System. A HPC system managed by the College of Medical, Veterinary and Life Sciences and Information Services’ Research Computing as a Service within the University of Glasgow: [MARS](https://hpc.gla.ac.uk/clusters/mars/)|
|MVLS|College of Medical, Veterinary and Life Sciences within the University of Glasgow: [University of Glasgow – Colleges – College of Medical, Veterinary & Life Sciences](https://www.gla.ac.uk/colleges/mvls/)|
|Active Directory|Active Directory is a directory service that provides the methods for storing directory data and making this data available to network users. The product is develop and maintained by Microsoft: [Active Directory Domain Services overview](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)|
|Ivanti|Refers to the IT service management tool provided by the software company Ivanti. The University of Glasgow is using this tool to facilitate delivery, receipt and management of Service Requests from users within the University: <https://www.gla.ac.uk/selfservice>|
|`none` account|Is a Slurm account on MARS, used for individual work, not associated with research projects, or to test the platform before applying for a project. The values assigned to a given user are described here, where “Max Single User” refers to the values in the none account: [min_max_values]()|
|Project|A project is a research project, that has been approved to use MARS for computational work. Projects are subject to usage charges: [getting_project]()|
|Shared Research Facilities|Also called SRF, is a function within MVLS, that helps researchers within their projects: [University of Glasgow – Colleges – College of Medical, Veterinary & Life Sciences – Shared Research Facilities](https://www.gla.ac.uk/colleges/mvls/shared-research-facilities/)|
|Alces|Company that manages and hosts MARS. Originally contracted through Dell, but now in direct contact with the MARS admins: [Alces Flight Supercomputing by Subscription](https://alces-flight.com/)|
|PI|Principal Investigator. The lead researcher within a research project.|



