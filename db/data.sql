INSERT INTO Role (roleID, roleName) VALUES
  (1, 'Owner'),
  (2, 'Customer')
ON CONFLICT DO NOTHING;

INSERT INTO Customer (customerID, name, email, phone) VALUES
  (1, 'Jane Doe', 'jane@example.com', '555-0101'),
  (2, 'Mark Smith', 'mark@example.com', '555-0102')
ON CONFLICT DO NOTHING;

-- These passwordHash values are placeholders, not usable password hashes.
INSERT INTO "User" (userID, name, email, passwordHash, roleID, customerID) VALUES
  (1, 'John Admin', 'admin@example.com', 'test-key-hash-owner', 1, NULL),
  (2, 'Jane Doe', 'jane@example.com', 'test-key-hash-customer', 2, 1)
ON CONFLICT DO NOTHING;

INSERT INTO LeadStatus (statusID, statusName) VALUES
  (1, 'Inquiry'),
  (2, 'Accepted'),
  (3, 'Declined')
ON CONFLICT DO NOTHING;

INSERT INTO Lead (leadID, customerID, summary, statusID, submissionDate) VALUES
  (1, 1, 'Custom logo design', 2, '2026-10-01'),
  (2, 2, 'Business card design', 3, '2026-10-05')
ON CONFLICT DO NOTHING;

INSERT INTO ProjectStatus (statusID, statusName, statusOrder) VALUES
  (1, 'Inquiry', 1),
  (2, 'Consultation', 2),
  (3, 'Quoting', 3),
  (4, 'In Progress', 4),
  (5, 'Client Review', 5),
  (6, 'Completed', 6)
ON CONFLICT DO NOTHING;

INSERT INTO Project (projectID, customerID, leadID, statusID, projectName, description) VALUES
  (1, 1, 1, 4, 'Custom Logo', 'Logo design for customer')
ON CONFLICT DO NOTHING;

INSERT INTO ProjectStatusHistory (historyID, projectID, prevID, newID, changedAt, changedBy) VALUES
  (1, 1, 2, 3, '2026-10-10 09:00:00', 1),
  (2, 1, 3, 4, '2026-10-15 14:30:00', 1)
ON CONFLICT DO NOTHING;

INSERT INTO Attachment (attachmentID, projectID, uploadedBy, fileName, storagePath, uploadedAt) VALUES
  (1, 1, 2, 'logo-reference.png', '/uploads/project1/logo-reference.png', '2026-10-08 11:00:00')
ON CONFLICT DO NOTHING;

INSERT INTO Communication (communicationID, projectID, userID, content, createdAt) VALUES
  (1, 1, 1, 'Discussed initial logo concepts with customer.', '2026-10-09 13:00:00')
ON CONFLICT DO NOTHING;

INSERT INTO Feedback (feedbackID, projectID, content, submittedAt) VALUES
  (1, 1, 'Please make the text slightly larger.', '2026-10-20 10:00:00')
ON CONFLICT DO NOTHING;

INSERT INTO Notification (notificationID, userID, projectID, message, createdAt, readAt) VALUES
  (1, 2, 1, 'Your project has moved to In Progress.', '2026-10-15 14:30:00', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO FollowUp (followUpID, userID, leadID, projectID, description, dueDate, completedAt) VALUES
  (1, 1, NULL, 1, 'Follow up on initial design concepts.', '2026-10-25', NULL),
  (2, 1, 2, NULL, 'Contact customer regarding inquiry.', '2026-10-28', NULL)
ON CONFLICT DO NOTHING;

SELECT setval(pg_get_serial_sequence('customer', 'customerid'), MAX(customerid), true) FROM Customer;
SELECT setval(pg_get_serial_sequence('"User"', 'userid'), MAX(userid), true) FROM "User";
SELECT setval(pg_get_serial_sequence('lead', 'leadid'), MAX(leadid), true) FROM Lead;
SELECT setval(pg_get_serial_sequence('project', 'projectid'), MAX(projectid), true) FROM Project;
SELECT setval(pg_get_serial_sequence('projectstatushistory', 'historyid'), MAX(historyid), true) FROM ProjectStatusHistory;
SELECT setval(pg_get_serial_sequence('attachment', 'attachmentid'), MAX(attachmentid), true) FROM Attachment;
SELECT setval(pg_get_serial_sequence('communication', 'communicationid'), MAX(communicationid), true) FROM Communication;
SELECT setval(pg_get_serial_sequence('feedback', 'feedbackid'), MAX(feedbackid), true) FROM Feedback;
SELECT setval(pg_get_serial_sequence('notification', 'notificationid'), MAX(notificationid), true) FROM Notification;
SELECT setval(pg_get_serial_sequence('followup', 'followupid'), MAX(followupid), true) FROM FollowUp;
