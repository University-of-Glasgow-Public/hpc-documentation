# Lochan: Cluster Usage Policy

To ensure the stability and usability of the platform for all users, there are certain rules and policies to abide by when using Lochan. This is a living document, so changes can be made at any time. If you have any questions regarding the contents of this page, feel free to get in contact with the admins via Ivanti.

---

1. Jobs must be run using the Slurm queueing system, interactive or batch jobs. Logging into any worker-nodes directly without a running allocation is forbidden.
2. No compute intensive tasks are to be run on the login node. The login-node is to be used for minor text editing, data management, submitting and monitoring jobs. The admin team reserves the right to kill processes, that constrain the login node, without warning.
3. Job submissions must specify the resources to the best estimate of the user, as to not waste cluster resources. This ensures the queueing system runs optimally and therefore the user’s jobs are starting as soon as possible. The admin team reserves the right delete poorly specified jobs.
4. Any data left on scratch spaces after the runtime of the job, may be deleted at any time and without notice.
5. All cluster storage is to be used only for active processing, and not for long term storage purposes. Please ensure, that all your scripts, datasets and results are saved to another system, as the admin team offers limited data recovery services.
6. The admin team reserves the right to delete, kill or hold jobs or processes that have an adverse effect on the whole system’s stability or health.
7. The job submission system has the capability to send automated emails about the progress of jobs. Users should ensure that the number of requested emails is not excessive and refrain from sending emails to any addresses outside the University of Glasgow domain. This means that affiliate/external user accounts should be using a University of Glasgow email address for job alerting.
8. The cluster is to be used for research purposes. Teaching and courses are not to be held using this cluster unless it was agreed upon prior with the admin team.
9. To ensure the stability and security of the cluster, maintenance is needed. This might result in access being restricted to the cluster or parts of it for certain periods of time. These maintenance windows will be announced via our Team on Microsoft Teams.

---

Please note that in addition to the Cluster Usage Policy users must also comply with the general [IT Policy](https://www.gla.ac.uk/myglasgow/it/policy/) of the University of Glasgow.