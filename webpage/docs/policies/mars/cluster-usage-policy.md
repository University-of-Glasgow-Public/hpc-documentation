# MARS Usage Policy

To ensure the stability and usability of the platform for all users, there are certain rules and policies to abide by when using MARS. This is a living document, so changes can be made at any time. We will inform of major changes through our [Team](https://teams.microsoft.com/l/team/19%3AwxHFDzABUVv4wp3EMEWnwPm2GFcBCVTY-dBfoYjMwI81%40thread.tacv2/conversations?groupId=d4b0eed5-0bb4-42d4-a7d1-82e0f8fe6694&tenantId=6e725c29-763a-4f50-81f2-2e254f0133c8) (Microsoft Teams). If you have any questions regarding the contents of this page, feel free to get in [contact with us](https://glasgow.saasiteu.com/Modules/SelfService/#serviceCatalog/request/AFB25E75ED5E40E4BDF84FDEE6108945).

---

1. Jobs must be run using the Slurm queueing system, interactive or batch jobs. Logging into any worker-nodes directly is forbidden.
2. No compute intensive task is to be run on the login-node (mars-login.ice.gla.ac.uk). The login-node is to be used for minor code/script editing, data management, submitting and monitoring jobs. The MARS team reserves the right to kill processes, that constrain the login-node, without warning.
3. Job submissions must specify the resources to the best estimate of the user, as to not waste cluster resources. This ensures the queueing system runs optimally and therefore the user’s jobs are starting as soon as possible. The MARS team reserves the right delete poorly specified jobs.
4. Any data left on scratch spaces after the runtime of the job, may be deleted at any time and without notice.
5. All storage on MARS is to be used only for active processing, and not for long term storage purposes. Please ensure, that all your scripts, datasets and results are saved to another system, as the MARS team offers limited data recovery services.
6. Access to Project shares will only be granted with permission from the PI.
7. The MARS team reserves the right to delete, kill or hold jobs or processes that have an adverse effect on the whole system’s stability or health.
8. The job submission system has the capability to send automated emails about the progress of jobs. Users should ensure that the number of requested emails is not excessive and refrain from sending emails to any email address outside the University of Glasgow domain.
Which means that affiliate/external user accounts should be using a UoG email address for job alerting.
9. MARS is to be used for research purposes. Teaching and courses are not to be held using this cluster unless it was agreed upon prior with the MARS team.
10. There is a maximum number of resources a single user can use on MARS. If their work needs more than the default, a project should be requested, as described here. The MARS team reserves the right to decline a project application, for reasons provided.
11. To ensure the stability and security of MARS, maintenance is needed. This might result in access being restricted to the cluster or parts of it for certain periods of time. These maintenance windows will be announced via our [Team](https://teams.microsoft.com/l/team/19%3AwxHFDzABUVv4wp3EMEWnwPm2GFcBCVTY-dBfoYjMwI81%40thread.tacv2/conversations?groupId=d4b0eed5-0bb4-42d4-a7d1-82e0f8fe6694&tenantId=6e725c29-763a-4f50-81f2-2e254f0133c8) (Microsoft Teams).
12. The resources on MARS are free to use by members of the University of Glasgow. We reserve the right to change this and implement a charging model in the future.

---

Please note that in addition to the MARS Usage Policy users must also comply with the general [IT Policy](https://www.gla.ac.uk/myglasgow/it/policy/) of the University of Glasgow.


