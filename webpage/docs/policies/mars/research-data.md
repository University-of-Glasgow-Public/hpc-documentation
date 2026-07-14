# Research Data on MARS

The MVLS Advanced Research System (MARS) is not a trusted research environment and is not intended to be used for the processing of sensitive data.  This document describes the MARS environment and is intended to inform potential users of MARS and data managers in support of making decisions around the storage and processing of data on MARS. 

## Users on MARS 

MARS is a multi-user environment, with wide eligibility for account registration.  The following classes of users are broadly allowed on MARS: 

- Research staff and students in MVLS 
- Undergraduate and PGT students sponsored by MVLS research staff 
- Other research staff in the University, most commonly those collaborating with MVLS research staff 
- Collaborators of MVLS research staff outside the University 
- Employees of the third-party management company responsible for MARS administration 

Proposals for MARS Projects will be assessed based on the eligibility criteria for individual users plus an assessment of the feasibility and suitability of the proposed work in the context of MARS.  

In all cases no assurances are available regarding the public benefits or ethical credentials of projects, nor are eligible MARS users required to complete specific training or provide specific accreditation regarding their understanding of, for example, data privacy issues. 

More information about users on MARS can be found here: [User Eligibility and Management](https://hpc.gla.ac.uk/policies/mars/user-eligibility/).

## Access to MARS compute nodes 

Access to an individual compute node is not restricted to a single user.  During execution of a user’s compute job on a node, other users may be allocated compute resources on the node through the resource manager.  Access to a compute node is not restricted to users with a currently scheduled job on that node. 

## File security 

Access permissions are set through POSIX security permissions with no enhanced access control.  The MARS administration team does not undertake audits of file permissions or user masks.  The default user mask is 0002. 

Users may be added to the following groups: 

- A default group to which all users are added, which is the user’s primary group.
- Groups corresponding to “research projects”, at the request of each project’s principal investigator.
- Groups reflecting permission to access restricted or licensed software, at the request of each user. 


## Data ingress and egress 

Data on the MARS storage system are not backed up or duplicated by the MARS administration team. 

The MARS administration team does not monitor, control, or restrict data ingest or exfiltration, beyond the application of POSIX file permissions.  No explicit mechanism exists to audit or record file access. 


## Elevated user permissions 

Various users on MARS have access to superuser privileges: 

- Users in the MARS Administration Group 
- Employees of the third-party management company 

Although user actions to gain superuser privileges are recorded through usual mechanisms, logging and auditing of actions undertaken are not regularly performed.  In general, it is not possible to tie an individual action taken with elevated permission to a specific user. 

The users in the MARS Administration Group with access to elevated permissions are not routinely shared with the users of MARS.  The University has the following information about those employees of the third-party management company with access to elevated permissions: 


Delivery of the subscribed service(s) as described in [Alces Terms and Conditions] may require Alces engineers to access data belonging to the Customer that is residing on the equipment being managed. Alces engineers will not remove, modify, share or view Customer data unnecessarily beyond actions necessary to continue delivering the described services or comply with UK law. Where appropriate, sensitive information (such as authentication credentials and security configuration information) will be obfuscated from log files shared with third-party service providers such as cloud or hardware maintenance vendors. Alces engineer access is secured by multi-factor authentication (MFA) with communications encrypted and audited via individual named accounts. Anti-phishing measures are enabled by default for Customer accounts – it is the  Customer’s responsibility to ensure that primary and secondary contact information is kept up to date to minimise delays when requesting service.   

The Customer agrees that Alces may collect and use usage and technical data and related information, including but not limited to information about your hardware, system and software, that is gathered periodically to facilitate the provision of software updates, product support and other services to Customers. Alces may use this information, as long as it is in a form that does not personally identify users of the Environment(s), to improve its products or to provide services or technologies to Customers.  

All services are delivered to Customers under the terms of our privacy policy which can be reviewed at the following URL:  
<https://alces-flight.com/privacy>


## Additional datasets on MARS common storage 

The MARS Administration Group does not control or provide mechanisms for users to control which additional datasets are present on MARS.  Some datasets may be stored in a location intended to be shared with multiple users; datasets here are usually added following user request with no intended oversight by the MARS Administration Group. 


## Identifiable NHS patient data 

The MARS system does not conform to the University of Glasgow Information governance and security requirements for the storage of identifiable NHS patient data. It should therefore NOT be used for the processing or storage of NHS patient data for research or any other purpose.  Storage or processing of anonymised or pseudonymised research data derived from NHS patients may be acceptable provided a Data Protection Impact Assessment has been carried out and has been approved by the relevant sponsor organisation. 


